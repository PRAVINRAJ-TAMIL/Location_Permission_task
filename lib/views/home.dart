import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/locationController.dart';
import '../controller/notificationController.dart';

class Home extends StatelessWidget {
  final LocationController locationController = Get.put(LocationController());
  final NotificationController notificationController =
      Get.put(NotificationController());

   Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              color: const Color(0xff565950),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Test App",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      fixedSize: Size(
                        MediaQuery.of(context).size.width / 1.1,
                        MediaQuery.of(context).size.height / 18,
                      ),
                    ),
                    onPressed: locationController.requestLocationPermission,
                    child: const Text('Request Location Permission'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      fixedSize: Size(
                        MediaQuery.of(context).size.width / 1.1,
                        MediaQuery.of(context).size.height / 18,
                      ),
                    ),
                    onPressed:
                        notificationController.requestNotificationPermission,
                    child: const Text('Request Notification Permission'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      fixedSize: Size(
                        MediaQuery.of(context).size.width / 1.1,
                        MediaQuery.of(context).size.height / 18,
                      ),
                    ),
                    onPressed: () async {
                      locationController.startLocationUpdates();
                      await notificationController
                          .showNotification("Location update started");
                    },
                    child: const Text('Start Location Update'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 239, 82, 70),
                      fixedSize: Size(
                        MediaQuery.of(context).size.width / 1.1,
                        MediaQuery.of(context).size.height / 18,
                      ),
                    ),
                    onPressed: () {
                      locationController.stopLocationUpdates();
                      notificationController
                          .showNotification("Location update stopped");
                    },
                    child: const Text('Stop Location Update'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            _container(context)
          ],
        ),
      ),
    );
  }

  Widget _container(context) {
    return Obx(() {
      return locationController.locationInfo.value.isNotEmpty
          ? Container(
              height: MediaQuery.of(context).size.height / 13,
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: BoxDecoration(
                  color: const Color(0xffd1d0d1),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          "Request",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${locationController.locationInfo.value}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        const Text(""),
                      ],
                    )
                  ],
                ),
              ),
            )
          : const SizedBox();
    });
  }

  Widget tapview() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemBuilder: (context, index) {
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          width: double.infinity,
          color: const Color(0xff565950),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Test App",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: Size(
                    MediaQuery.of(context).size.width / 1.1,
                    MediaQuery.of(context).size.height / 18,
                  ),
                ),
                onPressed: locationController.requestLocationPermission,
                child: const Text('Request Location Permission'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  fixedSize: Size(
                    MediaQuery.of(context).size.width / 1.1,
                    MediaQuery.of(context).size.height / 18,
                  ),
                ),
                onPressed: notificationController.requestNotificationPermission,
                child: const Text('Request Notification Permission'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  fixedSize: Size(
                    MediaQuery.of(context).size.width / 1.1,
                    MediaQuery.of(context).size.height / 18,
                  ),
                ),
                onPressed: () async {
                  locationController.startLocationUpdates();
                  await notificationController
                      .showNotification("Location update started");
                },
                child: const Text('Start Location Update'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 239, 82, 70),
                  fixedSize: Size(
                    MediaQuery.of(context).size.width / 1.1,
                    MediaQuery.of(context).size.height / 18,
                  ),
                ),
                onPressed: () {
                  locationController.stopLocationUpdates();
                  notificationController
                      .showNotification("Location update stopped");
                },
                child: const Text('Stop Location Update'),
              ),
            ],
          ),
        );
      },
    );
  }
}
