import 'package:get/get.dart';

import '../../../../lib.imports.dart';
import '../totem.imports.dart';

class TotemBinding extends Bindings {
  @override
  void dependencies() {
    //

    //-- CLIENTS --
    GraphQLCustomCLient graphQlClient = GraphQLCustomCLient();

    //-- DRIVERS --
    ILocalStorageDriver localStorageDriver = SharedPreferencesDriver();

    //----------------------------------- DATA ------------------------------

    Get.put<ITotemRepository>(
      TotemRepository(
        datasourceGraphql: TotemGraphQLDatasource(),
        datasourceRest: TotemRestDatasource(),
      ),
    );

    Get.put<IBatidasTotemRepository>(
      BatidasTotemRepository(
        localDatasource: BatidasTotemLocalDatasource(
          driver: SharedPreferencesDriver(),
        ),
      ),
    );

    Get.put<ISyncRepository>(
      SyncRepository(
        datasource: SyncGraphQLDatasource(
            // client: graphQlClient,
            ),
      ),
    );

    Get.put<IColabListRepository>(
      ColabListRepository(
        externalDatasource: ColabListDatasource(),
        localStorageDriver: localStorageDriver,
      ),
    );

    //---------------------------------- DOMAIN ------------------------------

    Get.put<ITotemCore>(TotemCore(), permanent: true);

    Get.put<IProcessQrColab>(ProcessQrColab());

    Get.put<ICarregarBatidas>(
      CarregarBatidas(
        batidasRepository: Get.find<IBatidasTotemRepository>(),
      ),
    );

    //USECASE REGISTRAR BATIDA
    Get.put<IRegistrarBatida>(RegistrarBatida(
      batidasRepository: Get.find<IBatidasTotemRepository>(),
      syncRepository: Get.find<ISyncRepository>(),
    ));

    //USECASE TENTAR REGISTRAR VIA QR
    Get.put<ITentarRegistrarBatidaViaQr>(
      TentarRegistrarBatidaViaQr(
        totemCore: Get.find<ITotemCore>(),
        usecaseProcessQrColab: Get.find<IProcessQrColab>(),
        usecaseRegistrarBatida: Get.find<IRegistrarBatida>(),
      ),
    );

    Get.put<IEncontrarColabViaMatricula>(
      EncontrarColabViaMatricula(
        usecaseTotemCore: Get.find<ITotemCore>(),
      ),
    );

    //USECASE TENTAR REGISTRAR VIA QR
    Get.put<ITentarRegistrarBatidaViaMatricula>(
      TentarRegistrarBatidaViaMatricula(
        usecaseEncontrarColabViaMatricula: Get.find<IEncontrarColabViaMatricula>(),
        usecaseRegistrarBatida: Get.find<IRegistrarBatida>(),
        // totemCore: Get.find<ITotemCore>(),
        // usecaseProcessQrColab: Get.find<IProcessQrColab>(),
        // usecaseRegistrarBatida: Get.find<IRegistrarBatida>(),
      ),
    );

    //USECASE TENTAR REGISTRAR VIA COLAB
    Get.put<ITentarRegistrarBatidaViaColab>(
      TentarRegistrarBatidaViaColab(
        usecaseRegistrarBatida: Get.find<IRegistrarBatida>(),
      ),
    );

    //USECASE BATIDAS HANDLER
    Get.put<IBatidasHandler>(
      BatidasHandler(
        usecaseTentarRegistrarBatidaViaQr: Get.find<ITentarRegistrarBatidaViaQr>(),
        usecaseTentarRegistrarBatidaViaMatricula: Get.find<ITentarRegistrarBatidaViaMatricula>(),
        usecaseTentarRegistrarBatidaViaColab: Get.find<ITentarRegistrarBatidaViaColab>(),
        repository: Get.find<IBatidasTotemRepository>(),
        usecaseCarregarBatidas: Get.find<ICarregarBatidas>(),
      ),
    );

    //COLAB LIST MANAGER
    Get.put<IColabListManager>(
      ColabListManager(
        repository: Get.find<IColabListRepository>(),
      ),
    );

    //USECASE PROCESS QR RESULT
    Get.put<IProcessQrResult>(ProcessQrResult());

    //USECASE LOGIN TOTEM
    Get.put<ILoginTotem>(LoginTotem(
      repository: Get.find<ITotemRepository>(),
    ));

    //*** REAJUSTAR ESSE USECASE, POR ENQUANTO ESTA NO MODULO E PRECISA FICAR AQUI NO CORE */
    Get.put<IActivateTotem>(
      ActivateTotem(
        totemCore: Get.find<ITotemCore>(),
        usecaseLogin: Get.find<ILoginTotem>(),
        usecaseProcessQrResult: Get.find<IProcessQrResult>(),
      ),
    );

    Get.put<IRotinaSync>(
      RotinaSync(
        batidasHandler: Get.find<IBatidasHandler>(),
        repository: Get.find<ISyncRepository>(),
      ),
    );

    Get.put<IInitializeHomePage>(
      InitializeHomePage(),
    );

    //USECASE INITIALIZE TOTEM
    Get.put<IInitializeTotem>(
      InitializeTotem(
        repository: Get.find<ITotemRepository>(),
        totemCore: Get.find<ITotemCore>(),
        usecaseActivateTotem: Get.find<IActivateTotem>(),
        usecaseBatidasHandler: Get.find<IBatidasHandler>(),
        usecaseRotinaSync: Get.find<IRotinaSync>(),
        usecaseInitializeHomePage: Get.find<IInitializeHomePage>(),
      ),
    );
  }
}
