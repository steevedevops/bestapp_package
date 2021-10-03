library bestapp_package;

// Services
export 'src/services/google/address-services.dart';
export 'src/services/api/api-services.dart';
export 'src/services/google/geo_services.dart';
export 'src/services/api/mdl-api.dart';
export 'src/services/google/place_services.dart';
export 'src/services/permission-services.dart';

// Widget
export 'src/widgets/cards/be-card-selected.dart';
export 'src/widgets/component/be-separate.dart';

export 'src/widgets/loading/be-load-circular.dart';
export 'src/widgets/loading/be-modal-progress-full.dart';
export 'src/widgets/avatars/be-avatar.dart';
export 'src/widgets/avatars/be-image-cached.dart';
export 'src/widgets/loading/shimmer-loading/shimmer.dart';
export 'src/widgets/loading/shimmer-loading/shimmer-loading.dart';
export 'src/widgets/buttons/be-button.dart';
export 'src/widgets/buttons/be-button-outline.dart';
export 'src/widgets/buttons/be-button-outline-icon.dart';
export 'src/widgets/buttons/be-button-icon.dart';

export 'src/widgets/appbar/be-appbar.dart';
export 'src/widgets/appbar/be-appbar-pref.dart';

export 'src/widgets/inputs/be-input-controller.dart';
export 'src/widgets/inputs/be-input-dropdown-controller.dart';
export 'src/widgets/inputs/be-input-autocomplete-controller.dart';

// Border
export 'src/widgets/component/border/be-border.dart';

// Dialog
export 'src/alerts/be-dialog-snack.dart';
export 'src/alerts/be-dialog-toast.dart';
export 'src/alerts/be-dialog-center.dart';
export 'src/alerts/dialog-utils.dart';

export 'src/models/enums.dart';

// Utils
export 'src/utils/bestapp-utils.dart';
export 'src/utils/colors-fromhex.dart';
export 'src/utils/compress-images.dart';
export 'src/utils/folderapp-docdir.dart';
export 'src/utils/getbytes-fromasset.dart';
export 'src/utils/preference-utils.dart';

// some model exported
export 'src/models/address-model.dart';
export 'src/models/place-search-model.dart';
export 'src/models/place-details-model.dart';

// Validators
export 'src/validators/cnpj_validator.dart';
export 'src/validators/cpf_validator.dart';

//Exports useful packages
export 'package:shared_preferences/shared_preferences.dart';
export 'package:geolocator/geolocator.dart';
export 'package:geocoder/geocoder.dart';
export 'package:geodesy/geodesy.dart';
export 'package:flutter_svg/svg.dart';
