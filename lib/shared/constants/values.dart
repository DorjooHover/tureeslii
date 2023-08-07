// urls
import 'package:landlord/shared/constants/assets.dart';
import 'package:landlord/shared/constants/strings.dart';

const String conditionUrl = "https://tureeslii.mn/information/TERMS";

const menuHelp = [
  {'url': '', "text": contractCondition},
  {'url': '', "text": cancelCondition},
  {'url': '', "text": serviceCondition},
  {'url': '', "text": contact},
];

const cities = [
  'Улаанбаатар',
  'Дархан',
  'Эрдэнэт',
];

const filterType = [
  'Орон сууц',
  'Хажуу өрөө',
  "Хаус",
  "Хашаа байшин",
  "Нийтийн байр",
  "Зуслангийн байр",
];
const filterItemsIncludedFee = [
  'Байрны мөнгө',
  'СӨХ',
  "Цахилгаан",
  "Интернет",
];

const filterOther = [
  'Цахилгаан халаалт',
  'Дотор 00',
  'Тавилгатай',
  'Гүний худаг',
  'Тагт',
  'Цахилгаан шат',
  'Угаалгын машин',
  'Зуух',
  'Хөргөгч',
  'Гал тогооны тавилга',
  'Интернет',
  'Кабелын ТВ',
  'Эмэгтэй',
  'Эрэгтэй',
  'Гэр бүл',
  'Тэжээвэр амьтан',
  'Тамхи татах',
  'Зочин урих',
];

const monthsValues = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

const filterVerification = ['Баталгаажсан', 'Онцлох'];

const filterFloor = ['1', '2-5', '5+'];
const paymentConditionValues = ['1 сар', "3 сар", "6 сар"];
const bailConditionValues = ['Хагас сараар' ,"3 сар", "6 сар"];
const contractConditionValues = ['Хагас сараар', "3 сар", "6 сар"];
const cancelConditionValues = ['Хатуу', "3 сар", "6 сар"];
const collaterals = ['Барьцаагүй'];
const whomRentValues = ['Гадаадын иргэн', "3 сар", "6 сар"];
// flat info
const heatingValues = ['Төвийн', "3 сар", "6 сар"];
const waterSupplyValues = ['Төвийн', "3 сар", "6 сар"];
const toiletValues = ['Нийтийн', "3 сар", "6 сар"];
// room info
const typeValues = ['Хажуу өрөө', "3 сар", "6 сар"];
// verification
const bankValues = ['Хажуу өрөө', "3 сар", "6 сар"];

const addAdValues = [
  location,
  general,
  conditionRestriction,
  flatFeature,
  flatInfo,
  roomInfo,
  imagesLibrary,
];

// sort
const sortValues = [
  {
    'text': 'Үнэ өсөхөөр',
    'icon': iconIncreasePrice,
    'is': 'false',
  },
  {
    'text': 'Үнэ буурахаар',
    'icon': iconDecreasePrice,
    'is': 'false',
  },
  {
    'text': 'Шинэ эхэндээ',
    'icon': iconNewStart,
    'is': 'true',
  },
  {
    'text': 'Хуучин эхэндээ',
    'icon': iconOldStart,
    'is': 'false',
  },
];

// navigation bar
const navbar = [
  {
    'icon': navLocation,
    'activeIcon': navLocationActive,
    'url': 'verification',
    'label': verificationDrawer,
  },
  {
    'icon': navBookmark,
    'activeIcon': navBookmarkActive,
    'url': 'myAds',
    'label': myAds,
  },
  {
    'icon': navNotification,
    'activeIcon': navNotificationActive,
    'url': navNotificationActive,
    'label': order,
  },
  {
    'icon': navOrder,
    'activeIcon': navOrderActive,
    'url': navOrderActive,
    'label': statistic,
  },
  {
    'icon': navMenu,
    'activeIcon': navMenuActive,
    'url': navMenuActive,
    'label': logout,
  },
];
