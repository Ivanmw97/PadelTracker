import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delyo/features/matches/state/matches_notifier.dart';
import 'package:delyo/features/matches/state/matches_state.dart';
import 'package:delyo/providers/repository_providers.dart';

/// Provider for matches state and notifier
///
/// Exposes the MatchesState and provides access to match operations
/// through the MatchesNotifier.
final matchesProvider = StateNotifierProvider<MatchesNotifier, MatchesState>((
  ref,
) {
  final repository = ref.watch(matchRepositoryProvider);
  return MatchesNotifier(repository);
});
