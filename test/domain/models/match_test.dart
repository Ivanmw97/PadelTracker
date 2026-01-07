import 'package:flutter_test/flutter_test.dart';
import 'package:delyo/domain/enums/match_type.dart';
import 'package:delyo/domain/enums/playing_side.dart';
import 'package:delyo/domain/models/match.dart';
import 'package:delyo/domain/models/match_result.dart';
import 'package:delyo/domain/models/padel_set.dart';
import 'package:delyo/domain/models/player.dart';

void main() {
  group('Match', () {
    const testPlayer1 = Player(id: '1', name: 'Partner');
    const testPlayer2 = Player(id: '2', name: 'Opponent 1');
    const testPlayer3 = Player(id: '3', name: 'Opponent 2');
    const testResult = MatchResult(
      sets: [PadelSet(userTeamGames: 6, opponentTeamGames: 4)],
    );
    final testDateTime = DateTime(2025, 1, 15, 10, 0);

    test('should create a match with required fields', () {
      final match = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
      );

      expect(match.id, equals('match1'));
      expect(match.matchType, equals(MatchType.friendly));
      expect(match.dateTime, equals(testDateTime));
      expect(match.playingSide, equals(PlayingSide.right));
      expect(match.partner, equals(testPlayer1));
      expect(match.opponent1, equals(testPlayer2));
      expect(match.opponent2, equals(testPlayer3));
      expect(match.result, equals(testResult));
      expect(match.performanceRating, isNull);
      expect(match.notes, isNull);
      expect(match.duration, isNull);
      expect(match.location, isNull);
    });

    test('should create a match with optional fields', () {
      final testDuration = Duration(hours: 1, minutes: 30);
      final match = Match(
        id: 'match1',
        matchType: MatchType.tournament,
        dateTime: testDateTime,
        playingSide: PlayingSide.left,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
        performanceRating: 4,
        notes: 'Great match!',
        duration: testDuration,
        location: 'Club Padel Central',
      );

      expect(match.performanceRating, equals(4));
      expect(match.notes, equals('Great match!'));
      expect(match.duration, equals(testDuration));
      expect(match.location, equals('Club Padel Central'));
    });

    test('should support all match types', () {
      final friendlyMatch = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
      );

      final leagueMatch = Match(
        id: 'match2',
        matchType: MatchType.league,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
      );

      final tournamentMatch = Match(
        id: 'match3',
        matchType: MatchType.tournament,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
      );

      expect(friendlyMatch.matchType, equals(MatchType.friendly));
      expect(leagueMatch.matchType, equals(MatchType.league));
      expect(tournamentMatch.matchType, equals(MatchType.tournament));
    });

    test('should support both playing sides', () {
      final rightSideMatch = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
      );

      final leftSideMatch = Match(
        id: 'match2',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.left,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
      );

      expect(rightSideMatch.playingSide, equals(PlayingSide.right));
      expect(leftSideMatch.playingSide, equals(PlayingSide.left));
    });

    test('should be equal when all fields match', () {
      final testDuration = Duration(hours: 1, minutes: 30);
      final match1 = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
        performanceRating: 4,
        notes: 'Great match!',
        duration: testDuration,
        location: 'Club Padel Central',
      );

      final match2 = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
        performanceRating: 4,
        notes: 'Great match!',
        duration: testDuration,
        location: 'Club Padel Central',
      );

      expect(match1, equals(match2));
      expect(match1.hashCode, equals(match2.hashCode));
    });

    test('should not be equal when id differs', () {
      final match1 = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
      );

      final match2 = Match(
        id: 'match2',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
      );

      expect(match1, isNot(equals(match2)));
    });

    test('should not be equal when match type differs', () {
      final match1 = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
      );

      final match2 = Match(
        id: 'match1',
        matchType: MatchType.league,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
      );

      expect(match1, isNot(equals(match2)));
    });

    test('should not be equal when playing side differs', () {
      final match1 = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
      );

      final match2 = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.left,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
      );

      expect(match1, isNot(equals(match2)));
    });

    test('should not be equal when performance rating differs', () {
      final match1 = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
        performanceRating: 4,
      );

      final match2 = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
        performanceRating: 5,
      );

      expect(match1, isNot(equals(match2)));
    });

    test('should not be equal when notes differ', () {
      final match1 = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
        notes: 'Great match!',
      );

      final match2 = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
        notes: 'Good match!',
      );

      expect(match1, isNot(equals(match2)));
    });

    test('toString should include id, type, and date', () {
      final match = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
      );

      final str = match.toString();
      expect(str, contains('match1'));
      expect(str, contains('friendly'));
      expect(str, contains('2025'));
    });

    test('should handle performance rating range', () {
      for (int rating = 1; rating <= 5; rating++) {
        final match = Match(
          id: 'match$rating',
          matchType: MatchType.friendly,
          dateTime: testDateTime,
          playingSide: PlayingSide.right,
          partner: testPlayer1,
          opponent1: testPlayer2,
          opponent2: testPlayer3,
          result: testResult,
          performanceRating: rating,
        );

        expect(match.performanceRating, equals(rating));
      }
    });

    test('should not be equal when duration differs', () {
      final match1 = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
        duration: Duration(hours: 1),
      );

      final match2 = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
        duration: Duration(hours: 2),
      );

      expect(match1, isNot(equals(match2)));
    });

    test('should not be equal when location differs', () {
      final match1 = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
        location: 'Club A',
      );

      final match2 = Match(
        id: 'match1',
        matchType: MatchType.friendly,
        dateTime: testDateTime,
        playingSide: PlayingSide.right,
        partner: testPlayer1,
        opponent1: testPlayer2,
        opponent2: testPlayer3,
        result: testResult,
        location: 'Club B',
      );

      expect(match1, isNot(equals(match2)));
    });
  });
}
