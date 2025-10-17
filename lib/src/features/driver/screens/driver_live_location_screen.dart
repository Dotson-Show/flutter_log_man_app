import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../widgets/inline_message_display.dart';
import '../../../hooks/use_async_message_handler.dart';
import '../../..//core/location_service.dart';

class DriverLiveLocationScreen extends HookConsumerWidget {
  const DriverLiveLocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (messageState, messageController) = useAsyncMessageHandler();
    final positionStream = ref.watch(locationStreamProvider);

    final mapController = useMemoized(() => MapController());
    final currentLatLng = useState<LatLng?>(null);
    final isMapReady = useState(false);

    ref.listen(locationStreamProvider, (prev, next) {
      next.when(
        data: (pos) {
          final latLng = LatLng(pos.latitude, pos.longitude);
          currentLatLng.value = latLng;
          if (isMapReady.value) {
            mapController.move(latLng, 15);
          }
        },
        loading: () => messageController.showLoading('Getting current location...'),
        error: (err, _) => messageController.showError(err.toString()),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Live Location', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          InlineMessageDisplay(
            errorMessage: messageState.errorMessage,
            successMessage: messageState.successMessage,
            warningMessage: messageState.warningMessage,
            infoMessage: messageState.infoMessage,
            isLoading: messageState.isLoading,
            loadingMessage: messageState.loadingMessage,
            onDismissError: messageController.clearError,
            onDismissSuccess: messageController.clearSuccess,
            onDismissWarning: () => messageController.clearAll(),
            onDismissInfo: () => messageController.clearAll(),
          ),
          Expanded(
            child: positionStream.when(
              data: (pos) {
                final center = LatLng(pos.latitude, pos.longitude);
                return FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: center,
                    initialZoom: 15,
                    onMapReady: () {
                      isMapReady.value = true;
                    },
                  ),
                  children: [
                    TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', userAgentPackageName: 'revoltrans_app_beta'),
                    MarkerLayer(markers: [
                      if (currentLatLng.value != null)
                        Marker(
                          point: currentLatLng.value!,
                          width: 40,
                          height: 40,
                          child: const Icon(Icons.local_shipping, color: Colors.red, size: 36),
                        ),
                    ]),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Location error: $err')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => ref.read(locationServiceProvider).requestPermissionAndStart(),
        label: const Text('Enable Tracking'),
        icon: const Icon(Icons.my_location),
      ),
    );
  }
}




