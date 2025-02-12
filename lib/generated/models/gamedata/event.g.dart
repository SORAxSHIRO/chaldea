// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../models/gamedata/event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterMission _$MasterMissionFromJson(Map json) => MasterMission(
      id: json['id'] as int,
      startedAt: json['startedAt'] as int,
      endedAt: json['endedAt'] as int,
      closedAt: json['closedAt'] as int,
      missions: (json['missions'] as List<dynamic>)
          .map(
              (e) => EventMission.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      quests: (json['quests'] as List<dynamic>)
          .map((e) => BasicQuest.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

ItemSet _$ItemSetFromJson(Map json) => ItemSet(
      id: json['id'] as int,
      purchaseType: $enumDecode(_$PurchaseTypeEnumMap, json['purchaseType']),
      targetId: json['targetId'] as int,
      setNum: json['setNum'] as int,
    );

const _$PurchaseTypeEnumMap = {
  PurchaseType.none: 'none',
  PurchaseType.item: 'item',
  PurchaseType.equip: 'equip',
  PurchaseType.friendGacha: 'friendGacha',
  PurchaseType.servant: 'servant',
  PurchaseType.setItem: 'setItem',
  PurchaseType.quest: 'quest',
  PurchaseType.eventShop: 'eventShop',
  PurchaseType.eventSvtGet: 'eventSvtGet',
  PurchaseType.manaShop: 'manaShop',
  PurchaseType.storageSvt: 'storageSvt',
  PurchaseType.storageSvtequip: 'storageSvtequip',
  PurchaseType.bgm: 'bgm',
  PurchaseType.costumeRelease: 'costumeRelease',
  PurchaseType.bgmRelease: 'bgmRelease',
  PurchaseType.lotteryShop: 'lotteryShop',
  PurchaseType.eventFactory: 'eventFactory',
  PurchaseType.itemAsPresent: 'itemAsPresent',
  PurchaseType.commandCode: 'commandCode',
  PurchaseType.gift: 'gift',
  PurchaseType.eventSvtJoin: 'eventSvtJoin',
  PurchaseType.assist: 'assist',
  PurchaseType.kiaraPunisherReset: 'kiaraPunisherReset',
};

NiceShop _$NiceShopFromJson(Map json) => NiceShop(
      id: json['id'] as int,
      shopType: $enumDecodeNullable(_$ShopTypeEnumMap, json['shopType']) ??
          ShopType.eventItem,
      releaseConditions: (json['releaseConditions'] as List<dynamic>?)
              ?.map((e) =>
                  ShopRelease.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      slot: json['slot'] as int,
      priority: json['priority'] as int,
      name: json['name'] as String,
      infoMessage: json['infoMessage'] as String? ?? "",
      payType: $enumDecode(_$PayTypeEnumMap, json['payType']),
      cost: ItemAmount.fromJson(Map<String, dynamic>.from(json['cost'] as Map)),
      purchaseType: $enumDecode(_$PurchaseTypeEnumMap, json['purchaseType']),
      targetIds: (json['targetIds'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      itemSet: (json['itemSet'] as List<dynamic>?)
              ?.map(
                  (e) => ItemSet.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      setNum: json['setNum'] as int? ?? 1,
      limitNum: json['limitNum'] as int,
      defaultLv: json['defaultLv'] as int? ?? 0,
      defaultLimitCount: json['defaultLimitCount'] as int? ?? 0,
      scriptName: json['scriptName'] as String?,
      scriptId: json['scriptId'] as String?,
      script: json['script'] as String?,
    );

const _$ShopTypeEnumMap = {
  ShopType.none: 'none',
  ShopType.eventItem: 'eventItem',
  ShopType.mana: 'mana',
  ShopType.rarePri: 'rarePri',
  ShopType.svtStorage: 'svtStorage',
  ShopType.svtEquipStorage: 'svtEquipStorage',
  ShopType.stoneFragments: 'stoneFragments',
  ShopType.svtAnonymous: 'svtAnonymous',
  ShopType.bgm: 'bgm',
  ShopType.limitMaterial: 'limitMaterial',
  ShopType.grailFragments: 'grailFragments',
  ShopType.svtCostume: 'svtCostume',
  ShopType.startUpSummon: 'startUpSummon',
  ShopType.shop13: 'shop13',
};

const _$PayTypeEnumMap = {
  PayType.stone: 'stone',
  PayType.qp: 'qp',
  PayType.friendPoint: 'friendPoint',
  PayType.mana: 'mana',
  PayType.ticket: 'ticket',
  PayType.eventItem: 'eventItem',
  PayType.chargeStone: 'chargeStone',
  PayType.stoneFragments: 'stoneFragments',
  PayType.anonymous: 'anonymous',
  PayType.rarePri: 'rarePri',
  PayType.item: 'item',
  PayType.grailFragments: 'grailFragments',
  PayType.free: 'free',
};

ShopRelease _$ShopReleaseFromJson(Map json) => ShopRelease(
      condValues: (json['condValues'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      condType: toEnumCondType(json['condType'] as Object),
      condNum: json['condNum'] as int,
      priority: json['priority'] as int? ?? 0,
      isClosedDisp: json['isClosedDisp'] as bool,
      closedMessage: json['closedMessage'] as String,
      closedItemName: json['closedItemName'] as String,
    );

EventReward _$EventRewardFromJson(Map json) => EventReward(
      groupId: json['groupId'] as int,
      point: json['point'] as int,
      gifts: (json['gifts'] as List<dynamic>)
          .map((e) => Gift.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

EventPointGroup _$EventPointGroupFromJson(Map json) => EventPointGroup(
      groupId: json['groupId'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
    );

EventPointBuff _$EventPointBuffFromJson(Map json) => EventPointBuff(
      id: json['id'] as int,
      funcIds:
          (json['funcIds'] as List<dynamic>?)?.map((e) => e as int).toList() ??
              const [],
      groupId: json['groupId'] as int? ?? 0,
      eventPoint: json['eventPoint'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      background: $enumDecode(_$ItemBGTypeEnumMap, json['background']),
      value: json['value'] as int,
    );

const _$ItemBGTypeEnumMap = {
  ItemBGType.zero: 'zero',
  ItemBGType.bronze: 'bronze',
  ItemBGType.silver: 'silver',
  ItemBGType.gold: 'gold',
  ItemBGType.questClearQPReward: 'questClearQPReward',
};

EventMissionConditionDetail _$EventMissionConditionDetailFromJson(Map json) =>
    EventMissionConditionDetail(
      id: json['id'] as int,
      missionTargetId: json['missionTargetId'] as int,
      missionCondType: json['missionCondType'] as int,
      logicType: json['logicType'] as int,
      targetIds: (json['targetIds'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      addTargetIds: (json['addTargetIds'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      targetQuestIndividualities:
          (json['targetQuestIndividualities'] as List<dynamic>?)
                  ?.map((e) =>
                      NiceTrait.fromJson(Map<String, dynamic>.from(e as Map)))
                  .toList() ??
              const [],
      conditionLinkType: $enumDecode(
          _$DetailMissionCondLinkTypeEnumMap, json['conditionLinkType']),
      targetEventIds: (json['targetEventIds'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
    );

const _$DetailMissionCondLinkTypeEnumMap = {
  DetailMissionCondLinkType.eventStart: 'eventStart',
  DetailMissionCondLinkType.missionStart: 'missionStart',
  DetailMissionCondLinkType.masterMissionStart: 'masterMissionStart',
  DetailMissionCondLinkType.randomMissionStart: 'randomMissionStart',
};

EventMissionCondition _$EventMissionConditionFromJson(Map json) =>
    EventMissionCondition(
      id: json['id'] as int,
      missionProgressType: $enumDecode(
          _$MissionProgressTypeEnumMap, json['missionProgressType']),
      priority: json['priority'] as int? ?? 0,
      condGroup: json['condGroup'] as int,
      condType: toEnumCondType(json['condType'] as Object),
      targetIds:
          (json['targetIds'] as List<dynamic>).map((e) => e as int).toList(),
      targetNum: json['targetNum'] as int,
      conditionMessage: json['conditionMessage'] as String,
      closedMessage: json['closedMessage'] as String? ?? "",
      flag: json['flag'] as int? ?? 0,
      detail: json['detail'] == null
          ? null
          : EventMissionConditionDetail.fromJson(
              Map<String, dynamic>.from(json['detail'] as Map)),
    );

const _$MissionProgressTypeEnumMap = {
  MissionProgressType.none: 'none',
  MissionProgressType.regist: 'regist',
  MissionProgressType.openCondition: 'openCondition',
  MissionProgressType.start: 'start',
  MissionProgressType.clear: 'clear',
  MissionProgressType.achieve: 'achieve',
};

EventMission _$EventMissionFromJson(Map json) => EventMission(
      id: json['id'] as int,
      type: $enumDecodeNullable(_$MissionTypeEnumMap, json['type']) ??
          MissionType.event,
      dispNo: json['dispNo'] as int,
      name: json['name'] as String,
      startedAt: json['startedAt'] as int? ?? 0,
      endedAt: json['endedAt'] as int? ?? 0,
      closedAt: json['closedAt'] as int? ?? 0,
      rewardType: $enumDecode(_$MissionRewardTypeEnumMap, json['rewardType']),
      gifts: (json['gifts'] as List<dynamic>)
          .map((e) => Gift.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      bannerGroup: json['bannerGroup'] as int? ?? 0,
      priority: json['priority'] as int? ?? 0,
      conds: (json['conds'] as List<dynamic>?)
              ?.map((e) => EventMissionCondition.fromJson(
                  Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
    );

const _$MissionTypeEnumMap = {
  MissionType.none: 'none',
  MissionType.event: 'event',
  MissionType.weekly: 'weekly',
  MissionType.daily: 'daily',
  MissionType.extra: 'extra',
  MissionType.limited: 'limited',
  MissionType.complete: 'complete',
  MissionType.random: 'random',
};

const _$MissionRewardTypeEnumMap = {
  MissionRewardType.gift: 'gift',
  MissionRewardType.extra: 'extra',
  MissionRewardType.set: 'set',
};

EventTowerReward _$EventTowerRewardFromJson(Map json) => EventTowerReward(
      floor: json['floor'] as int,
      gifts: (json['gifts'] as List<dynamic>)
          .map((e) => Gift.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

EventTower _$EventTowerFromJson(Map json) => EventTower(
      towerId: json['towerId'] as int,
      name: json['name'] as String,
      rewards: (json['rewards'] as List<dynamic>)
          .map((e) =>
              EventTowerReward.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

EventLotteryBox _$EventLotteryBoxFromJson(Map json) => EventLotteryBox(
      boxIndex: json['boxIndex'] as int? ?? 0,
      talkId: json['talkId'] as int? ?? 0,
      no: json['no'] as int,
      type: json['type'] as int? ?? 1,
      gifts: (json['gifts'] as List<dynamic>?)
              ?.map((e) => Gift.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      maxNum: json['maxNum'] as int,
      isRare: json['isRare'] as bool? ?? false,
    );

EventLottery _$EventLotteryFromJson(Map json) => EventLottery(
      id: json['id'] as int,
      slot: json['slot'] as int? ?? 0,
      payType: $enumDecode(_$PayTypeEnumMap, json['payType']),
      cost: ItemAmount.fromJson(Map<String, dynamic>.from(json['cost'] as Map)),
      priority: json['priority'] as int,
      limited: json['limited'] as bool,
      boxes: (json['boxes'] as List<dynamic>)
          .map((e) =>
              EventLotteryBox.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      talks: (json['talks'] as List<dynamic>?)
              ?.map((e) => EventLotteryTalk.fromJson(
                  Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
    );

EventLotteryTalk _$EventLotteryTalkFromJson(Map json) => EventLotteryTalk(
      talkId: json['talkId'] as int,
      no: json['no'] as int,
      guideImageId: json['guideImageId'] as int,
      beforeVoiceLines: (json['beforeVoiceLines'] as List<dynamic>?)
              ?.map((e) =>
                  VoiceLine.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      afterVoiceLines: (json['afterVoiceLines'] as List<dynamic>?)
              ?.map((e) =>
                  VoiceLine.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      isRare: json['isRare'] as bool,
    );

CommonConsume _$CommonConsumeFromJson(Map json) => CommonConsume(
      id: json['id'] as int,
      priority: json['priority'] as int,
      objectId: json['objectId'] as int,
      num: json['num'] as int,
    );

EventTreasureBoxGift _$EventTreasureBoxGiftFromJson(Map json) =>
    EventTreasureBoxGift(
      id: json['id'] as int,
      idx: json['idx'] as int,
      gifts: (json['gifts'] as List<dynamic>)
          .map((e) => Gift.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      collateralUpperLimit: json['collateralUpperLimit'] as int,
    );

EventTreasureBox _$EventTreasureBoxFromJson(Map json) => EventTreasureBox(
      slot: json['slot'] as int,
      id: json['id'] as int,
      idx: json['idx'] as int,
      treasureBoxGifts: (json['treasureBoxGifts'] as List<dynamic>)
          .map((e) => EventTreasureBoxGift.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .toList(),
      maxDrawNumOnce: json['maxDrawNumOnce'] as int,
      extraGifts: (json['extraGifts'] as List<dynamic>)
          .map((e) => Gift.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      commonConsume: CommonConsume.fromJson(
          Map<String, dynamic>.from(json['commonConsume'] as Map)),
    );

Event _$EventFromJson(Map json) => Event(
      id: json['id'] as int,
      type: $enumDecodeNullable(_$EventTypeEnumMap, json['type']) ??
          EventType.none,
      name: json['name'] as String,
      shortName: json['shortName'] as String? ?? "",
      detail: json['detail'] as String,
      noticeBanner: json['noticeBanner'] as String?,
      banner: json['banner'] as String?,
      icon: json['icon'] as String?,
      bannerPriority: json['bannerPriority'] as int? ?? 0,
      noticeAt: json['noticeAt'] as int,
      startedAt: json['startedAt'] as int,
      endedAt: json['endedAt'] as int,
      finishedAt: json['finishedAt'] as int,
      materialOpenedAt: json['materialOpenedAt'] as int,
      warIds:
          (json['warIds'] as List<dynamic>?)?.map((e) => e as int).toList() ??
              const [],
      shop: (json['shop'] as List<dynamic>?)
              ?.map(
                  (e) => NiceShop.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      rewards: (json['rewards'] as List<dynamic>?)
              ?.map((e) =>
                  EventReward.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      rewardScenes: (json['rewardScenes'] as List<dynamic>?)
              ?.map((e) => EventRewardScene.fromJson(
                  Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      pointGroups: (json['pointGroups'] as List<dynamic>?)
              ?.map((e) =>
                  EventPointGroup.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      pointBuffs: (json['pointBuffs'] as List<dynamic>?)
              ?.map((e) =>
                  EventPointBuff.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      missions: (json['missions'] as List<dynamic>?)
              ?.map((e) =>
                  EventMission.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      towers: (json['towers'] as List<dynamic>?)
              ?.map((e) =>
                  EventTower.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      lotteries: (json['lotteries'] as List<dynamic>?)
              ?.map((e) =>
                  EventLottery.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      treasureBoxes: (json['treasureBoxes'] as List<dynamic>?)
              ?.map((e) => EventTreasureBox.fromJson(
                  Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      voicePlays: (json['voicePlays'] as List<dynamic>?)
              ?.map((e) =>
                  EventVoicePlay.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      voices: (json['voices'] as List<dynamic>?)
              ?.map((e) =>
                  VoiceGroup.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
    );

const _$EventTypeEnumMap = {
  EventType.none: 'none',
  EventType.raidBoss: 'raidBoss',
  EventType.pvp: 'pvp',
  EventType.point: 'point',
  EventType.loginBonus: 'loginBonus',
  EventType.combineCampaign: 'combineCampaign',
  EventType.shop: 'shop',
  EventType.questCampaign: 'questCampaign',
  EventType.bank: 'bank',
  EventType.serialCampaign: 'serialCampaign',
  EventType.loginCampaign: 'loginCampaign',
  EventType.loginCampaignRepeat: 'loginCampaignRepeat',
  EventType.eventQuest: 'eventQuest',
  EventType.svtequipCombineCampaign: 'svtequipCombineCampaign',
  EventType.terminalBanner: 'terminalBanner',
  EventType.boxGacha: 'boxGacha',
  EventType.boxGachaPoint: 'boxGachaPoint',
  EventType.loginCampaignStrict: 'loginCampaignStrict',
  EventType.totalLogin: 'totalLogin',
  EventType.comebackCampaign: 'comebackCampaign',
  EventType.locationCampaign: 'locationCampaign',
  EventType.warBoard: 'warBoard',
  EventType.combineCosutumeItem: 'combineCosutumeItem',
  EventType.myroomMultipleViewCampaign: 'myroomMultipleViewCampaign',
  EventType.interludeCampaign: 'interludeCampaign',
};

EventRewardSceneGuide _$EventRewardSceneGuideFromJson(Map json) =>
    EventRewardSceneGuide(
      imageId: json['imageId'] as int,
      limitCount: json['limitCount'] as int? ?? 0,
      image: json['image'] as String,
      faceId: json['faceId'] as int? ?? 0,
      displayName: json['displayName'] as String?,
      weight: json['weight'] as int?,
      unselectedMax: json['unselectedMax'] as int?,
    );

EventRewardScene _$EventRewardSceneFromJson(Map json) => EventRewardScene(
      slot: json['slot'] as int,
      groupId: json['groupId'] as int,
      type: json['type'] as int,
      guides: (json['guides'] as List<dynamic>?)
              ?.map((e) => EventRewardSceneGuide.fromJson(
                  Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      tabOnImage: json['tabOnImage'] as String,
      tabOffImage: json['tabOffImage'] as String,
      image: json['image'] as String?,
      bg: json['bg'] as String,
      bgm: BgmEntity.fromJson(Map<String, dynamic>.from(json['bgm'] as Map)),
      afterBgm: BgmEntity.fromJson(
          Map<String, dynamic>.from(json['afterBgm'] as Map)),
      flags: (json['flags'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$EventRewardSceneFlagEnumMap, e))
              .toList() ??
          const [],
    );

const _$EventRewardSceneFlagEnumMap = {
  EventRewardSceneFlag.npcGuide: 'npcGuide',
  EventRewardSceneFlag.isChangeSvtByChangedTab: 'isChangeSvtByChangedTab',
  EventRewardSceneFlag.isHideTab: 'isHideTab',
};

EventVoicePlay _$EventVoicePlayFromJson(Map json) => EventVoicePlay(
      slot: json['slot'] as int,
      idx: json['idx'] as int,
      guideImageId: json['guideImageId'] as int,
      voiceLines: (json['voiceLines'] as List<dynamic>?)
              ?.map((e) =>
                  VoiceLine.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      confirmVoiceLines: (json['confirmVoiceLines'] as List<dynamic>?)
              ?.map((e) =>
                  VoiceLine.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      condType: toEnumCondType(json['condType'] as Object),
      condValue: json['condValue'] as int,
      startedAt: json['startedAt'] as int,
      endedAt: json['endedAt'] as int,
    );
