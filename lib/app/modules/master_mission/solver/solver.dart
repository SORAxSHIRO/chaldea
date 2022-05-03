import 'package:chaldea/models/models.dart';
import 'package:chaldea/packages/lp/lp.dart';
import 'scheme.dart';

class MissionSolver {
  // make sure [missions] is a copy
  Map<int, int> solve({
    required List<QuestPhase> quests,
    required List<CustomMission> missions,
  }) {
    final lp = convertLP(quests: quests, missions: missions);
    final sol = lp.solve(decimalPlaces: 0);
    final questNum = sol.x.length;
    Map<int, int> result = {};
    for (var i = 0; i < questNum; i++) {
      if (sol.x[i] != 0) {
        result.addAll({quests[i].id: sol.x[i].toInt()});
      }
    }
    return result;
  }

  LP convertLP({
    required List<QuestPhase> quests,
    required List<CustomMission> missions,
  }) {
    missions
        .removeWhere((mission) => mission.ids.isEmpty || mission.count <= 0);

    List<List<num>> aMat = [];
    for (final mission in List.of(missions)) {
      final row = <int>[];
      for (final quest in quests) {
        row.add(countMissionTarget(mission, quest));
      }
      if (row.any((e) => e > 0)) {
        aMat.add(row);
      } else {
        print(
            'remove invalid mission: ${mission.type}/${mission.count}/${mission.ids}');
        missions.remove(mission);
      }
    }

    return LP(
      aMat: aMat,
      bVec: missions.map((e) => e.count).toList(),
      cVec: quests.map((e) => e.consume).toList(),
      lpType: LPType.min,
      integer: true,
    );
  }

  static int countMissionTarget(CustomMission mission, QuestPhase quest) {
    switch (mission.type) {
      case CustomMissionType.trait:
        return quest.allEnemies
            .where((enemy) => NiceTrait.hasAllTraits(enemy.traits, mission.ids))
            .length;
      case CustomMissionType.questTrait:
        return NiceTrait.hasAnyTrait(quest.individuality, mission.ids) ? 1 : 0;
      case CustomMissionType.quest:
        return mission.ids.contains(quest.id) ? 1 : 0;
      case CustomMissionType.enemy:
        return quest.allEnemies
            .where((enemy) => mission.ids.contains(enemy.svt.id))
            .length;
      case CustomMissionType.servantClass:
        return quest.allEnemies
            .where((enemy) =>
                enemy.traits
                    .any((trait) => trait.name == Trait.basedOnServant) &&
                mission.ids.contains(enemy.svt.className.id))
            .length;
      case CustomMissionType.enemyClass:
        return quest.allEnemies
            .where((enemy) => mission.ids.contains(enemy.svt.className.id))
            .length;
      case CustomMissionType.enemyNotServantClass:
        return quest.allEnemies
            .where((enemy) =>
                enemy.traits
                    .any((trait) => trait.name == Trait.notBasedOnServant) &&
                mission.ids.contains(enemy.svt.className.id))
            .length;
    }
  }
}
