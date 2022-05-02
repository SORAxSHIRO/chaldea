import 'package:chaldea/packages/lp/lp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('LP max non-integer', () {
    final lp1 = LP(
      cVec: [4, 6, 2],
      aMat: [
        [4, 4, 0],
        [-1, 6, 0],
        [-1, 1, 1],
      ],
      bVec: [5, 5, 5],
      lpType: LPType.max,
    );
    final expectedLp1Sol = LPSol(
      cVec: lp1.cVec,
      aMat: lp1.aMat,
      bVec: lp1.bVec,
      lpType: lp1.lpType,
      integer: lp1.integer,
      z: 17.5,
      x: [1.25, 0, 6.25],
    );

    final lp1Sol = lp1.solve();
    expect([lp1Sol.z, lp1Sol.x], [expectedLp1Sol.z, expectedLp1Sol.x]);

    final lp2 = LP(
      cVec: [3, 1, 3],
      aMat: [
        [-1, 2, 1],
        [0, 4, -3],
        [1, -3, 2]
      ],
      bVec: [4, 2, 3],
      lpType: LPType.max,
    );
    final expectedLp2Sol = LPSol(
      cVec: lp1.cVec,
      aMat: lp1.aMat,
      bVec: lp1.bVec,
      lpType: lp1.lpType,
      integer: lp1.integer,
      z: 29,
      x: [5.33, 3, 3.33],
    );

    final lp2Sol = lp2.solve();
    expect([lp2Sol.z, lp2Sol.x], [expectedLp2Sol.z, expectedLp2Sol.x]);
  });

  test('LP min non-integer', () {
    final lp1 = LP(
      cVec: [5, 2],
      aMat: [
        [3, -1],
        [2, 3],
      ],
      bVec: [3, 5],
      lpType: LPType.min,
    );
    final expectedLp1Sol = LPSol(
      cVec: lp1.cVec,
      aMat: lp1.aMat,
      bVec: lp1.bVec,
      lpType: lp1.lpType,
      integer: lp1.integer,
      z: 8,
      x: [1.27, 0.82],
    );

    final lp1Sol = lp1.solve();
    expect([lp1Sol.z, lp1Sol.x], [expectedLp1Sol.z, expectedLp1Sol.x]);

    final lp2 = LP(
      cVec: [7, 6, 5],
      aMat: [
        [1, -3, 2],
        [2, 2, 3],
        [3, 1, 1]
      ],
      bVec: [6, 8, 9],
      lpType: LPType.min,
    );
    final expectedLp2Sol = LPSol(
      cVec: lp1.cVec,
      aMat: lp1.aMat,
      bVec: lp1.bVec,
      lpType: lp1.lpType,
      integer: lp1.integer,
      z: 25.8,
      x: [2.4, 0, 1.8],
    );

    final lp2Sol = lp2.solve();
    expect([lp2Sol.z, lp2Sol.x], [expectedLp2Sol.z, expectedLp2Sol.x]);
  });

  test('LP max integer', () {
    final lp1 = LP(
      cVec: [4, 6, 2],
      aMat: [
        [4, 4, 0],
        [-1, 6, 0],
        [-1, 1, 1],
      ],
      bVec: [5, 5, 5],
      lpType: LPType.max,
      integer: true,
    );
    final expectedLp1Sol = LPSol(
      cVec: lp1.cVec,
      aMat: lp1.aMat,
      bVec: lp1.bVec,
      lpType: lp1.lpType,
      integer: lp1.integer,
      z: 16,
      x: [1, 0, 6],
    );

    final lp1Sol = lp1.solve();
    expect([lp1Sol.z, lp1Sol.x], [expectedLp1Sol.z, expectedLp1Sol.x]);

    final lp2 = LP(
      cVec: [3, 1, 3],
      aMat: [
        [-1, 2, 1],
        [0, 4, -3],
        [1, -3, 2]
      ],
      bVec: [4, 2, 3],
      lpType: LPType.max,
      integer: true,
    );
    final expectedLp2Sol = LPSol(
      cVec: lp1.cVec,
      aMat: lp1.aMat,
      bVec: lp1.bVec,
      lpType: lp1.lpType,
      integer: lp1.integer,
      z: 23,
      x: [5, 2, 2],
    );

    final lp2Sol = lp2.solve();
    expect([lp2Sol.z, lp2Sol.x], [expectedLp2Sol.z, expectedLp2Sol.x]);
  });

  test('LP min integer', () {
    final lp1 = LP(
      cVec: [5, 2],
      aMat: [
        [3, -1],
        [2, 3],
      ],
      bVec: [3, 5],
      lpType: LPType.min,
      integer: true,
    );
    final expectedLp1Sol = LPSol(
      cVec: lp1.cVec,
      aMat: lp1.aMat,
      bVec: lp1.bVec,
      lpType: lp1.lpType,
      integer: lp1.integer,
      z: 12,
      x: [2, 1],
    );
    final lp1Sol = lp1.solve();
    expect([lp1Sol.z, lp1Sol.x], [expectedLp1Sol.z, expectedLp1Sol.x]);

    final lp2 = LP(
      cVec: [7, 6, 5],
      aMat: [
        [1, -3, 2],
        [2, 2, 3],
        [3, 1, 1]
      ],
      bVec: [6, 8, 9],
      lpType: LPType.min,
      integer: true,
    );
    final expectedLp2Sol = LPSol(
      cVec: lp1.cVec,
      aMat: lp1.aMat,
      bVec: lp1.bVec,
      lpType: lp1.lpType,
      integer: lp1.integer,
      z: 29,
      x: [2, 0, 3],
    );
    final lp2Sol = lp2.solve();
    expect([lp2Sol.z, lp2Sol.x], [expectedLp2Sol.z, expectedLp2Sol.x]);
  });
}
