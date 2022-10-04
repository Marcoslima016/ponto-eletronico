import 'package:get/get.dart';

import '../../ponto_virtual.imports.dart';
import '../../../../lib.imports.dart';

class PontoVirtualBinding extends Bindings {
  @override
  void dependencies() {
    //

    ///========================================= GLOBAL ==========================================

    //-- CLIENTS --
    GraphQLCustomCLient graphQlClient = GraphQLCustomCLient();

    //-- DRIVERS --
    ILocalStorageDriver localStorageDriver = SharedPreferencesDriver();

    ///

    ///======================================== ENDEREÇOS =========================================
    ///
    //NETWORK DATASOURCE
    Get.put<IEnderecosNetworkDataSource>(GraphQLDatasource(client: graphQlClient));

    //REPOSITORY
    Get.put<IEnderecosRepository>(EnderecosRepository(networkDataSource: Get.find<IEnderecosNetworkDataSource>(), localStorageDriver: localStorageDriver));

    //USECASES
    Get.put<ICarregarEnderecos>(CarregarEnderecos(repository: Get.find<IEnderecosRepository>())); //// CarregarEnderecos
    Get.put<IEnderecosPonto>(EnderecosPonto(carregarEnderecosUsecase: Get.find<ICarregarEnderecos>())); //// EnderecosPonto

    ///======================================= PONTO PESSOAL =======================================

    //PONTO PESSSOAL USECASE
    Get.put<IPontoPessoal>(PontoPessoal());

    ///-------- LISTA DE BATIDAS ---------

    //NETWORK DATASOURCE
    Get.put<IBatidasNetworkDatasource>(BatidasGraphQLDatasource(client: graphQlClient));

    //LOCAL DATASOURCE
    Get.put<IBatidasLocalDatasource>(BatidasLocalStorageDatasource(driver: localStorageDriver));

    ///-------- REGISTRAR BATIDA ---------

    //REPOSITORY
    Get.put<IBatidasRepository>(
        BatidasDoDiaRepository(
          localStorageDriver: localStorageDriver,
          networkDataSource: Get.find<IBatidasNetworkDatasource>(),
          // localDatasource: Get.find<IBatidasLocalDatasource>(),
        ),
        permanent: true);

    //USECASES
    Get.put<IRegistrarPontoPessoal>(RegistrarPontoPessoal());
    Get.put<IConfirmarBatidaForaDeLocal>(ConfirmarBatidaForaDeLocal());
    Get.put<IValidarTrabalhador>(ValidarTrabalhador());
    Get.put<IContabilizarBatida>(ContabilizarBatida(repository: Get.find<IBatidasRepository>()));

    //USECASES
    Get.put<IListaBatidasHandler>(ListaBatidasHandler(batidasRepository: Get.find<IBatidasRepository>()));

    ///-------- SINCRONIZAR BATIDA ---------

    //USECASES
    Get.put<ISincronizarBatidas>(
      SincronizarBatidas(repository: Get.find<IBatidasRepository>()),
      permanent: true,
    );

    ///
    ///
    ///=========================================== TOTEM ===========================================
  }
}
