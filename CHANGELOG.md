# Change Log

Relatório de versões e as suas novidades/alterações. 

<!-- ================================== v0.1.6 ================================== -->
---
## [0.1.6] Prod - 13-09-2022 

### Added
- Alterado package recognize: Adicionado popup de instruções do reconhecimento facial. 

### Changed
- Totem: Foi alterado o layout do botão de emergência exibido após não conseguir identificar uma face. 

### Fixed


<!-- ================================== v0.1.5 ================================== -->
---
## [0.1.5] Prod - 31-08-2022 

### Added

### Changed
- Posição inicial da camera no modo de batida via QR Code. Até o momento, era utilizada a câmera traseira do dispositivo. Agora, passou a ser utilizada a câmera frontal, com a opção de virar a câmera em tempo de execução. 

### Fixed


<!-- ================================== v0.1.4 ================================== -->
---
## [0.1.4] Prod - 19-08-2022 

### Added

### Changed
- Corrigido processo de sincronização, para evitar batidas duplicadas e outros bugs durante o processo. 

### Fixed



<!-- ================================== v0.1.3 ================================== -->
---
## [0.1.3] Prod - 01-08-2022 

### Added

### Changed
- Migração AWS -> Oracle. Foi ajustada a baseUrl das requisições

### Fixed



<!-- ================================== v0.1.2 ================================== -->
---
## [0.1.2] Prod - 28-07-2022 

### Added

### Changed

### Fixed
- Ajustado processos de sincronização dos logs.

<!-- ================================== v0.1.1 ================================== -->
---
## [0.1.1] Prod - 28-07-2022 

### Added
- Ajustes Reconhecimento facial: Foi implementado processo de botão de emergência, onde após X segundos tentando identificar a face, é exibido um botão de emergência. 

### Changed

### Fixed

<!-- ================================== v0.1.0 ================================== -->
---
## [0.1.0] Prod Android - 23-07-2022 

### Added
- Processos de Log definitivos ( Processo de batida; Execução do app )
- Ajustes no timeout de contabilização da batida. Foi adicionado timeout váriavel, de modo a utilizar um valor no processo batida, e outro valor diferente no processo de sincronização. 
### Changed

### Fixed
