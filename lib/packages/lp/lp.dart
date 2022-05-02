import 'package:fraction/fraction.dart';
import 'package:tabular/tabular.dart';

enum LPType { max, min }

class LP {
  final List<num> cVec;
  final List<List<num>> aMat;
  final List<num> bVec;
  final LPType lpType;
  bool integer;

  LP({
    required this.cVec,
    required this.aMat,
    required this.bVec,
    required this.lpType,
    this.integer = false,
  });

  LPSol solve({int decimalPlaces = 2}) {
    var tableau = Tableau(
      cVec: cVec,
      aMat: aMat,
      bVec: bVec,
      decimalPlaces: decimalPlaces,
    );
    var dualSimplexTableau =
        lpType == LPType.max ? tableau : tableau.toDualMax();
    var simplex = Simplex(tableau: tableau, lpType: lpType);
    var dualSimplex = DualSimplex(tableau: dualSimplexTableau);

    final isOptimal = simplex.isOptimal;
    final isFeasible = dualSimplex.isFeasible;

    if (!isOptimal && !isFeasible) {
      tableau = dualSimplex.solve(ignoreOptimal: true);
      simplex = Simplex(tableau: tableau, lpType: LPType.max);
      tableau = simplex.solve();
    } else if (!isOptimal) {
      tableau = simplex.solve();
    } else if (!isFeasible) {
      tableau = dualSimplex.solve();
    } else {
      // ... What? the LP is already solved?
    }

    if (integer) {
      while (!tableau.isSolutionInteger) {
        final row = tableau.firstFoundNonIntegerXRow;
        final colNum = row.length;

        List<Fraction> gomorysCut = List.from(
            row.map((v) => v.toMixedFraction().fractionalPart.negate()));
        gomorysCut.insert(colNum - 1, Fraction(1));
        tableau.addConstraint(gomorysCut);

        dualSimplex = DualSimplex(tableau: tableau);
        tableau = dualSimplex.solve();
      }
    }

    return LPSol(
      cVec: cVec,
      aMat: aMat,
      bVec: bVec,
      lpType: lpType,
      integer: integer,
      z: tableau.z,
      x: tableau.x,
    );
  }
}

class LPSol {
  final List<num> cVec;
  final List<List<num>> aMat;
  final List<num> bVec;
  final LPType lpType;
  final bool integer;
  final num z;
  final List<num> x;

  LPSol({
    required this.cVec,
    required this.aMat,
    required this.bVec,
    required this.lpType,
    required this.integer,
    required this.z,
    required this.x,
  });

  @override
  String toString() {
    var sol = [
      ['Linear ${integer ? 'integer ' : ''}programing type', lpType.name],
      ['cVec', cVec],
      ['aMat', aMat],
      ['bVec', bVec],
      ['z', z],
      ['x', x],
    ];

    return tabular(
      sol,
      style: Style.mysql,
      border: Border.all,
      rowDividers: null,
    );
  }
}

class Tableau {
  final List<num> cVec;
  final List<List<num>> aMat;
  final List<num> bVec;
  int decimalPlaces;
  List<int> basicVarIndex = [];
  List<List<Fraction>> matrix = [];

  Tableau({
    required this.cVec,
    required this.aMat,
    required this.bVec,
    required this.decimalPlaces,
  }) {
    final varsNum = cVec.length;
    final constraintsNum = bVec.length;

    basicVarIndex = List.generate(constraintsNum, (index) => varsNum + index);

    matrix.add(initialZRow(constraintsNum));
    matrix.addAll(generateInitialRows(constraintsNum));
  }

  List<Fraction> initialZRow(int constraintsNum) {
    // Z - c1*x1 - c2*x2 - ... - cn*xn + 0s1 + 0s2 + ... + 0sn = 0

    // +-------+-----+-----+-----+-----+-----+-----+-----+-----+-----+
    // | BASIC | x1  | x2  | ... | xn  | s1  | s2  | ... | sn  | SOL |
    // +-------+-----+-----+-----+-----+-----+-----+-----+-----+-----+
    // | Z     | ... | ... | ... | ... | ... | ... | ... | ... | ... |
    // +-------+-----+-----+-----+-----+-----+-----+-----+-----+-----+
    List<Fraction> zRow = [];

    // +-------+-----+-----+-----+-----+-----+-----+-----+-----+-----+
    // | BASIC | x1  | x2  | ... | xn  | s1  | s2  | ... | sn  | SOL |
    // +-------+-----+-----+-----+-----+-----+-----+-----+-----+-----+
    // | Z     | -c1 | -c2 | ... | -cn | ... | ... | ... | ... | ... |
    // +-------+-----+-----+-----+-----+-----+-----+-----+-----+-----+
    zRow.addAll(cVec.map((n) => n.toFraction().negate()));

    // +-------+-----+-----+-----+-----+-----+-----+-----+-----+-----+
    // | BASIC | x1  | x2  | ... | xn  | s1  | s2  | ... | sn  | SOL |
    // +-------+-----+-----+-----+-----+-----+-----+-----+-----+-----+
    // | Z     | -c1 | -c2 | ... | -cn |  0  |  0  | ... |  0  | ... |
    // +-------+-----+-----+-----+-----+-----+-----+-----+-----+-----+
    zRow.addAll(List.generate(constraintsNum, (i) => Fraction(0)));

    // +-------+-----+-----+-----+-----+-----+-----+-----+-----+-----+
    // | BASIC | x1  | x2  | ... | xn  | s1  | s2  | ... | sn  | SOL |
    // +-------+-----+-----+-----+-----+-----+-----+-----+-----+-----+
    // | Z     | -c1 | -c2 | ... | -cn |  0  |  0  | ... |  0  |  0  |
    // +-------+-----+-----+-----+-----+-----+-----+-----+-----+-----+
    zRow.add(Fraction(0));

    return zRow;
  }

  List<List<Fraction>> generateInitialRows(int constraintsNum) {
    List<List<Fraction>> rows = [];
    for (var i = 0; i < constraintsNum; i++) {
      List<Fraction> row = [];

      row.addAll(aMat[i].map((n) => n.toFraction()));

      row.addAll(List.generate(
          constraintsNum, (index) => index == i ? Fraction(1) : Fraction(0)));

      row.add(bVec[i].toFraction());

      rows.add(row);
    }

    return rows;
  }

  void rowByScalar(int row, Fraction scalar) {
    matrix[row] = List.from(matrix[row].map((v) => (v * scalar).reduce()));
  }

  void rowPlusRowByScalar(int row, int referenceRow, Fraction scalar) {
    final rowLength = matrix[row].length;
    for (var i = 0; i < rowLength; i++) {
      matrix[row][i] += matrix[referenceRow][i] * scalar;
      matrix[row][i] = matrix[row][i].reduce();
    }
  }

  void addConstraint(List<Fraction> constraint) {
    final rowNum = matrix.length;
    final colNum = matrix.first.length;
    for (var i = 0; i < rowNum; i++) {
      matrix[i].insert(colNum - 1, Fraction(0));
    }
    matrix.add(constraint);
    basicVarIndex.add(colNum - 1);
  }

  bool isBasicVar(int col) {
    return basicVarIndex.contains(col);
  }

  bool get isSolutionInteger {
    final xNum = x.length;
    for (var i = 0; i < xNum; i++) {
      if (x[i].toMixedFraction().fractionalPart.toDouble() != 0) {
        return false;
      }
    }

    return true;
  }

  List<Fraction> get firstFoundNonIntegerXRow {
    final rowNum = matrix.length;
    for (var i = 1; i < rowNum; i++) {
      if (matrix[i].last.toMixedFraction().fractionalPart.toDouble() != 0) {
        return matrix[i];
      }
    }

    return [];
  }

  Tableau toDualMax() {
    final List<List<num>> _aMat =
        List.from(aMat.map((r) => List<num>.from(r.map((a) => -1 * a))));
    final List<num> _bVec = List.from(bVec.map((b) => -1 * b));

    return Tableau(
      cVec: cVec,
      aMat: _aMat,
      bVec: _bVec,
      decimalPlaces: decimalPlaces,
    );
  }

  num get z => double.parse((matrix.first.last.toDouble()).toStringAsFixed(2));

  List<num> get x {
    final varsNum = cVec.length;
    final basicVarNum = basicVarIndex.length;
    List<num> x = List.generate(varsNum, (index) => 0);
    for (var i = 0; i < basicVarNum; i++) {
      if (basicVarIndex[i] < varsNum) {
        x[basicVarIndex[i]] =
            double.parse((matrix[i + 1].last.toDouble()).toStringAsFixed(2));
      }
    }
    return x;
  }

  @override
  String toString() {
    final varsNum = cVec.length;
    final constraintsNum = bVec.length;

    List<List<dynamic>> matrixFormated = [];

    List<String> title = ['BASIC'];
    for (var i = 0; i < varsNum; i++) {
      title.add('x${i + 1}');
    }
    for (var i = 0; i < constraintsNum; i++) {
      title.add('s${i + 1}');
    }
    title.add('SOL');
    matrixFormated.add(title);
    matrixFormated.add(['Z', ...matrix[0]]);

    for (var i = 0; i < constraintsNum; i++) {
      String basicVar = '';
      if (basicVarIndex[i] < varsNum) {
        basicVar = 'x${basicVarIndex[i] + 1}';
      } else {
        basicVar = 's${basicVarIndex[i] - varsNum + 1}';
      }

      matrixFormated.add([basicVar, ...matrix[i + 1]]);
    }

    return tabular(
      matrixFormated,
      style: Style.mysql,
      border: Border.all,
      rowDividers: null,
    );
  }
}

class Simplex {
  Tableau tableau;
  final LPType lpType;

  Simplex({required this.tableau, required this.lpType});

  bool get isOptimal {
    final colNum = tableau.matrix[0].length;
    for (var i = 0; i < colNum; i++) {
      if (lpType == LPType.max) {
        if (tableau.matrix[0][i].toDouble() < 0) {
          return false;
        }
      } else {
        if (tableau.matrix[0][i].toDouble() > 0) {
          return false;
        }
      }
    }

    return true;
  }

  Tableau solve() {
    while (!isOptimal) {
      final col = inputVarCol();
      final row = outputVarRow(col);
      tableau.basicVarIndex[row - 1] = col;

      final pivot = tableau.matrix[row][col];
      tableau.rowByScalar(row, pivot.inverse());

      final rowNum = tableau.matrix.length;
      for (var i = 0; i < rowNum; i++) {
        if (i != row) {
          final scalar = tableau.matrix[i][col];
          tableau.rowPlusRowByScalar(i, row, scalar.negate());
        }
      }
    }
    return tableau;
  }

  int inputVarCol() {
    final colNum = tableau.matrix[0].length;
    var inputVar = 0.0;
    var inputVarCol = 0;
    for (var i = 0; i < colNum - 1; i++) {
      if (!tableau.isBasicVar(i)) {
        if (lpType == LPType.max &&
            tableau.matrix[0][i].toDouble() < inputVar) {
          inputVar = tableau.matrix[0][i].toDouble();
          inputVarCol = i;
        } else if (lpType == LPType.min &&
            tableau.matrix[0][i].toDouble() > inputVar) {
          inputVar = tableau.matrix[0][i].toDouble();
          inputVarCol = i;
        }
      }
    }
    return inputVarCol;
  }

  int outputVarRow(int inputVarCol) {
    final rowNum = tableau.matrix.length;
    var outputRel = double.infinity;
    var outputVarRow = 0;
    for (var i = 1; i < rowNum; i++) {
      if (tableau.matrix[i][inputVarCol].toDouble() > 0) {
        final rel = tableau.matrix[i].last / tableau.matrix[i][inputVarCol];
        if (rel.toDouble() < outputRel) {
          outputRel = rel.toDouble();
          outputVarRow = i;
        }
      }
    }

    return outputVarRow;
  }
}

class DualSimplex {
  Tableau tableau;

  DualSimplex({required this.tableau});

  bool get isFeasible {
    for (var i = 0; i < tableau.matrix.length; i++) {
      if (tableau.matrix[i].last.toDouble() < 0) {
        return false;
      }
    }

    return true;
  }

  Tableau solve({bool ignoreOptimal = false}) {
    while (!isFeasible) {
      final row = outputVarRow();
      final col = inputVarCol(row);
      tableau.basicVarIndex[row - 1] = col;

      final pivot = tableau.matrix[row][col];
      tableau.rowByScalar(row, pivot.inverse());

      final rowNum = tableau.matrix.length;
      for (var i = 0; i < rowNum; i++) {
        if (i != row) {
          final scalar = tableau.matrix[i][col];
          tableau.rowPlusRowByScalar(i, row, scalar.negate());
        }
      }
    }
    return tableau;
  }

  int outputVarRow() {
    final rowNum = tableau.matrix.length;
    var inputVar = 0.0;
    var inputVarRow = 0;
    for (var i = 1; i < rowNum; i++) {
      if (tableau.matrix[i].last.toDouble() < inputVar) {
        inputVar = tableau.matrix[i].last.toDouble();
        inputVarRow = i;
      }
    }
    return inputVarRow;
  }

  int inputVarCol(int inputVarRow) {
    final colNum = tableau.matrix[inputVarRow].length;
    var outputRel = double.infinity;
    var outputVarRow = 0;
    for (var i = 0; i < colNum - 1; i++) {
      if (tableau.matrix[inputVarRow][i].toDouble() < 0) {
        final rel = tableau.matrix[0][i] / tableau.matrix[inputVarRow][i];
        if (rel.toDouble().abs() < outputRel) {
          outputRel = rel.toDouble().abs();
          outputVarRow = i;
        }
      }
    }

    return outputVarRow;
  }
}
