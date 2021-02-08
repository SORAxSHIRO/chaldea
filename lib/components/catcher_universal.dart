import 'dart:io';
import 'dart:math';

/// This package is platform-compatibility fix for catcher.
/// If official support is release, this should be removed.
import 'package:catcher/catcher.dart';
import 'package:catcher/model/platform_type.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logging/logging.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/src/entities/attachment.dart';
import 'package:path/path.dart' as pathlib;

import 'config.dart';
import 'constants.dart';
import 'utils.dart';

export 'page_report_mode_cross.dart';

class SilentReportModeCross extends SilentReportMode {
  @override
  List<PlatformType> getSupportedPlatforms() => PlatformType.values.toList();
}

class DialogReportModeCross extends DialogReportMode {
  @override
  List<PlatformType> getSupportedPlatforms() => PlatformType.values.toList();
}

class FileHandlerCross extends FileHandler {
  FileHandlerCross(File file,
      {bool enableDeviceParameters = true,
      bool enableApplicationParameters = true,
      bool enableStackTrace = true,
      bool enableCustomParameters = true,
      bool printLogs = false})
      : super(file,
            enableDeviceParameters: enableDeviceParameters,
            enableApplicationParameters: enableApplicationParameters,
            enableStackTrace: enableStackTrace,
            enableCustomParameters: enableCustomParameters,
            printLogs: printLogs);

  @override
  List<PlatformType> getSupportedPlatforms() => PlatformType.values.toList();
}

class ConsoleHandlerCross extends ConsoleHandler {
  ConsoleHandlerCross(
      {bool enableDeviceParameters = true,
      bool enableApplicationParameters = true,
      bool enableStackTrace = true,
      bool enableCustomParameters = true})
      : super(
            enableDeviceParameters: enableDeviceParameters,
            enableApplicationParameters: enableApplicationParameters,
            enableStackTrace: enableStackTrace,
            enableCustomParameters: enableCustomParameters);

  @override
  List<PlatformType> getSupportedPlatforms() => PlatformType.values.toList();
}

class ToastHandlerCross extends ReportHandler {
  final Duration duration;
  final EasyLoadingToastPosition toastPosition;
  final String customMessage;

  ToastHandlerCross({this.duration, this.toastPosition, this.customMessage});

  @override
  Future<bool> handle(Report error) async {
    EasyLoading.showToast(_getErrorMessage(error),
        duration: duration, toastPosition: toastPosition);
    return true;
  }

  String _getErrorMessage(Report error) {
    if (customMessage != null && customMessage.length > 0) {
      return customMessage;
    } else {
      return "Error occurred: ${error.error}";
    }
  }

  @override
  List<PlatformType> getSupportedPlatforms() => PlatformType.values.toList();
}

class EmailAutoHandlerCross extends EmailAutoHandler {
  final Logger _logger = Logger("EmailAutoHandler");
  final List<File> attachments;
  final bool screenshot;

  EmailAutoHandlerCross(String smtpHost, int smtpPort, String senderEmail,
      String senderName, String senderPassword, List<String> recipients,
      {this.screenshot = false,
      bool enableSsl = false,
      bool enableDeviceParameters = true,
      bool enableApplicationParameters = true,
      bool enableStackTrace = true,
      bool enableCustomParameters = true,
      String emailTitle,
      String emailHeader,
      this.attachments = const [],
      bool sendHtml = true,
      bool printLogs = false})
      : super(smtpHost, smtpPort, senderEmail, senderName, senderPassword,
            recipients,
            enableSsl: enableSsl,
            enableDeviceParameters: enableDeviceParameters,
            enableApplicationParameters: enableApplicationParameters,
            enableStackTrace: enableStackTrace,
            enableCustomParameters: enableCustomParameters,
            emailTitle: emailTitle,
            emailHeader: emailHeader,
            sendHtml: sendHtml,
            printLogs: printLogs);

  @override
  List<PlatformType> getSupportedPlatforms() => PlatformType.values.toList();

  @override
  Future<bool> handle(Report error) async {
    return _sendMail(error);
  }

  Map<String, List<Report>> _sentReports = {};

  Future<bool> _sendMail(Report report) async {
    // don't send email repeatedly
    String contact = db.userData.contactInfo?.trim() ?? '';
    List<Report> _cachedReports = _sentReports.putIfAbsent(contact, () => []);
    if (_cachedReports.any((element) =>
        report.error.toString() == element.error.toString() &&
        report.stackTrace.toString() == element.stackTrace.toString())) {
      return true;
    }
    try {
      final message = new Message()
        ..from = new Address(this.senderEmail, this.senderName)
        ..recipients.addAll(recipients)
        ..subject = _getEmailTitle(report)
        ..text = _setupRawMessageText(report)
        ..attachments = _getAttachments(attachments);
      if (screenshot) {
        String shotFn = pathlib.join(db.paths.appPath, 'crash.png');
        File shotFile = await db.screenshotController?.capture(
            path: shotFn, pixelRatio: 1.5, delay: Duration(seconds: 2));
        if (shotFile?.existsSync() == true) {
          message.attachments.add(FileAttachment(shotFile));
        }
      }
      if (sendHtml) {
        message.html = _setupHtmlMessageText(report);
      }
      _printLog("Sending email...");

      var result = await send(message, _setupSmtpServer());
      if (result != null) {
        _cachedReports.add(report);
        _printLog("Email result: mail: ${result.mail} "
            "sending start time: ${result.messageSendingStart} "
            "sending end time: ${result?.messageSendingEnd}");
      } else {
        _printLog("Result is empty - failed to send email");
      }
      return true;
    } catch (stacktrace, exception) {
      _printLog(stacktrace.toString());
      _printLog(exception.toString());
      return false;
    }
  }

  List<Attachment> _getAttachments(List<File> files) {
    List<Attachment> attachments = [];
    for (File file in files) {
      if (file.existsSync()) {
        // set file limit less than 1MB
        if (file.lengthSync() > 1024 * 1024) {
          String s = file.readAsStringSync();
          s.substring(s.length - min(s.length, 1000 * 1000), s.length);
          file.writeAsStringSync(s);
        }
        attachments.add(FileAttachment(file));
      }
    }
    return attachments;
  }

  SmtpServer _setupSmtpServer() {
    return SmtpServer(smtpHost,
        port: smtpPort,
        ssl: enableSsl,
        username: senderEmail,
        password: senderPassword);
  }

  String _getEmailTitle(Report report) {
    if (emailTitle != null && emailTitle.length > 0) {
      return emailTitle;
    } else {
      return "Error report: >> ${report.error} <<";
    }
  }

  String _setupHtmlMessageText(Report report) {
    StringBuffer buffer = StringBuffer("");
    if (emailHeader != null && emailHeader.length > 0) {
      buffer.write(emailHeader);
      buffer.write("<hr><br>");
    }

    if (db.userData.contactInfo?.isNotEmpty == true) {
      buffer.write("<h2>Contact information:</h2>");
      buffer.write("${db.userData.contactInfo}<br><br>");
    }

    buffer.write("<h2>Error:</h2>");
    buffer.write(report.error.toString());
    buffer.write(report.errorDetails?.exceptionAsString() ?? '');
    buffer.write("<hr><br>");
    if (enableStackTrace) {
      buffer.write("<h2>Stack trace:</h2>");
      buffer.write(report.stackTrace.toString().replaceAll("\n", "<br>"));
      if (report.stackTrace?.toString()?.trim()?.isNotEmpty != true) {
        buffer.write(
            report.errorDetails.stack.toString().replaceAll('\n', '<br>'));
      }
      buffer.write("<hr><br>");
    }
    if (enableDeviceParameters) {
      buffer.write("<h2>Device parameters:</h2>");
      for (var entry in report.deviceParameters.entries) {
        buffer.write("<b>${entry.key}</b>: ${entry.value}<br>");
      }
      buffer.write("<hr><br>");
    }
    if (enableApplicationParameters) {
      buffer.write("<h2>Application parameters:</h2>");
      for (var entry in report.applicationParameters.entries) {
        buffer.write("<b>${entry.key}</b>: ${entry.value}<br>");
      }
      buffer.write("<br><br>");
    }

    if (enableCustomParameters) {
      buffer.write("<h2>Custom parameters:</h2>");
      for (var entry in report.customParameters.entries) {
        buffer.write("<b>${entry.key}</b>: ${entry.value}<br>");
      }
      buffer.write("<br><br>");
    }

    return buffer.toString();
  }

  String _setupRawMessageText(Report report) {
    StringBuffer buffer = StringBuffer("");
    if (emailHeader != null && emailHeader.length > 0) {
      buffer.write(emailHeader);
      buffer.write("\n\n");
    }
    if (db.userData.contactInfo?.isNotEmpty == true) {
      buffer.write('Contact information: ${db.userData.contactInfo}\n\n');
    }

    buffer.write("Error:\n");
    buffer.write(report.error.toString());
    buffer.write("\n\n");
    if (enableStackTrace) {
      buffer.write("Stack trace:\n");
      buffer.write(report.stackTrace.toString());
      buffer.write("\n\n");
    }
    if (enableDeviceParameters) {
      buffer.write("Device parameters:\n");
      for (var entry in report.deviceParameters.entries) {
        buffer.write("${entry.key}: ${entry.value}\n");
      }
      buffer.write("\n\n");
    }
    if (enableApplicationParameters) {
      buffer.write("Application parameters:\n");
      for (var entry in report.applicationParameters.entries) {
        buffer.write("${entry.key}: ${entry.value}\n");
      }
      buffer.write("\n\n");
    }
    if (enableCustomParameters) {
      buffer.write("Custom parameters:\n");
      for (var entry in report.customParameters.entries) {
        buffer.write("${entry.key}: ${entry.value}\n");
      }
      buffer.write("\n\n");
    }
    return buffer.toString();
  }

  void _printLog(String log) {
    if (printLogs) {
      _logger.info(log);
    }
  }
}

EmailAutoHandlerCross kEmailAutoHandlerCross(
        {List<File> attachments = const []}) =>
    EmailAutoHandlerCross(
      'smtp.qiye.aliyun.com',
      465,
      b64('Y2hhbGRlYS1jbGllbnRAbmFydW1pLmNj'),
      'Chaldea Crash',
      b64('Q2hhbGRlYUBjbGllbnQ='),
      [kSupportTeamEmailAddress],
      attachments: attachments,
      screenshot: true,
      enableSsl: true,
      printLogs: true,
    );
