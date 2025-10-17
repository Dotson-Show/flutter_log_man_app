// lib/src/features/customer/screens/history_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../controllers/journey_controller.dart';
import '../../../models/journey.dart';
import '../../../widgets/journey_card.dart';
import 'package:go_router/go_router.dart';

part 'history_screen.g.dart';

// History screen initialization state using generator pattern
@riverpod
class HistoryInitialized extends _$HistoryInitialized {
  @override
  bool build() => false;

  void setInitialized() {
    state = true;
  }
}

// Filter state for history screen
@riverpod
class HistoryFilter extends _$HistoryFilter {
  @override
  String build() => 'all'; // all, pending, delivered, cancelled

  void setFilter(String filter) {
    state = filter;
  }
}

class HistoryScreen extends HookConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journeyState = ref.watch(journeyControllerProvider);
    final hasInitialized = ref.watch(historyInitializedProvider);
    final currentFilter = ref.watch(historyFilterProvider);
    final scrollController = useScrollController();

    // Initialize data on first build
    useEffect(() {
      if (!hasInitialized) {
        ref.read(historyInitializedProvider.notifier).setInitialized();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(journeyControllerProvider.notifier).fetchJourneys();
        });
      }
      return null;
    }, [hasInitialized]);

    // Set up scroll listener for pagination
    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
          final currentState = ref.read(journeyControllerProvider);

          currentState.whenData((data) {
            if (data != null) {
              final controller = ref.read(journeyControllerProvider.notifier);
              if (controller.canLoadMore()) {
                final (journeys, pagination) = data;
                controller.fetchJourneys(
                  page: pagination.page + 1,
                  append: true,
                );
              }
            }
          });
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journey History'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref
                .read(journeyControllerProvider.notifier)
                .fetchJourneys(),
            tooltip: 'Refresh',
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filter journeys',
            onSelected: (value) {
              ref.read(historyFilterProvider.notifier).setFilter(value);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'all',
                child: Row(
                  children: [
                    Icon(
                      currentFilter == 'all' ? Icons.radio_button_checked : Icons.radio_button_off,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text('All Journeys'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'pending',
                child: Row(
                  children: [
                    Icon(
                      currentFilter == 'pending' ? Icons.radio_button_checked : Icons.radio_button_off,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text('Pending'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'in_transit',
                child: Row(
                  children: [
                    Icon(
                      currentFilter == 'in_transit' ? Icons.radio_button_checked : Icons.radio_button_off,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text('In Transit'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delivered',
                child: Row(
                  children: [
                    Icon(
                      currentFilter == 'delivered' ? Icons.radio_button_checked : Icons.radio_button_off,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text('Delivered'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'cancelled',
                child: Row(
                  children: [
                    Icon(
                      currentFilter == 'cancelled' ? Icons.radio_button_checked : Icons.radio_button_off,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text('Cancelled'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: journeyState.when(
        data: (data) {
          if (data == null) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "No journey history",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Your completed journeys will appear here",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          final (journeys, pagination) = data;

          // Filter journeys based on current filter
          final filteredJourneys = _filterJourneys(journeys, currentFilter);

          if (filteredJourneys.isEmpty && currentFilter != 'all') {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.filter_list_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    "No ${currentFilter.replaceAll('_', ' ')} journeys",
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Try changing the filter",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref
                        .read(historyFilterProvider.notifier)
                        .setFilter('all'),
                    child: const Text('Show All'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Filter indicator
              if (currentFilter != 'all')
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: Row(
                    children: [
                      Icon(
                        Icons.filter_list,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Showing ${currentFilter.replaceAll('_', ' ')} journeys (${filteredJourneys.length})',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => ref
                            .read(historyFilterProvider.notifier)
                            .setFilter('all'),
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                ),

              // Journey list
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await ref.read(journeyControllerProvider.notifier).fetchJourneys();
                  },
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(8.0),
                    itemCount: filteredJourneys.length +
                        (pagination.page < pagination.pages && currentFilter == 'all' ? 1 : 0),
                    itemBuilder: (context, index) {
                      // Show loading indicator at the end if there are more pages
                      // Only show for 'all' filter since pagination applies to all data
                      if (index == filteredJourneys.length && currentFilter == 'all') {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: Column(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 8),
                                Text("Loading more journeys..."),
                              ],
                            ),
                          ),
                        );
                      }

                      final journey = filteredJourneys[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        elevation: 1,
                        child: JourneyCard(
                          journey: journey,
                          onTap: () => context.push('/customer/journeys/${journey.id}'),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("Loading journey history..."),
            ],
          ),
        ),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  "Error loading history",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => ref
                      .read(journeyControllerProvider.notifier)
                      .fetchJourneys(),
                  icon: const Icon(Icons.refresh),
                  label: const Text("Retry"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Journey> _filterJourneys(List<Journey> journeys, String filter) {
    if (filter == 'all') return journeys;

    return journeys.where((journey) {
      return journey.status.toLowerCase() == filter.toLowerCase();
    }).toList();
  }
}