import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../lib.imports.dart';
import 'sync_list.controller.dart';
import 'widgets/sync_item_card.widget.dart';

class SyncListView extends StatelessWidget {
  SyncListController controller = SyncListController();
  double w;
  double h;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fila de sincronização",
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
      ),
      body: Container(
        width: w * 100,
        height: double.infinity,
        // color: Colors.grey,
        child: Obx(() {
          // List<BatidaTotem> listaBatidas = controller.listaBatidas.value;
          // var p = "";

          if (controller.listaBatidas.length > 0) {
            return ListView.builder(
              itemCount: controller.listaBatidas.length,
              itemBuilder: (context, index) {
                BatidaTotem itemBatida = controller.listaBatidas[index];
                var p = "";
                if (itemBatida.status != BatidaStatus.synchronized) {
                  return SyncItemCard(
                    itemBatida: itemBatida,
                  );
                } else {
                  return Container();
                }
              },
            );
          } else {
            return Container(
              width: w * 100,
              height: double.infinity,
              padding: EdgeInsets.only(right: w * 10, left: w * 10),
              child: Center(
                child: Text(
                  "Não há batidas na fila de sincronização",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
