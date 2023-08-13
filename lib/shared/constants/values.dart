// urls
import 'package:tureeslii/shared/constants/assets.dart';
import 'package:tureeslii/shared/constants/strings.dart';

const String conditionUrl = "https://tureeslii.mn/information/TERMS";
const String fileUrl = "https://tureeslii.mn/files/";

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

const payTypesValues = ['income', 'tetgeleg', 'parents', 'husband_wife'];
const payTypesMn = ['Цалин/Орлого', 'Тэтгэлэг', 'эцэг/эх', 'эхнэр/нөхөр'];
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
const collaterals = ['Барьцаагүй'];

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
    'label': 'Байршил',
  },
  {
    'icon': navBookmark,
    'activeIcon': navBookmarkActive,
    'label': 'Хадгалсан',
  },
  {
    'icon': navNotification,
    'activeIcon': navNotificationActive,
    'label': 'Сонордуулга',
  },
  {
    'icon': navOrder,
    'activeIcon': navOrderActive,
    'label': 'Захиалга',
  },
  {
    'icon': navMenu,
    'activeIcon': navMenuActive,
    'label': 'Цэс',
  },
];

const List<String> priceIncluded = [
  'electric',
  // here
  'accommodation',
  'internet',
  'water',
  // here
  'sokh',
];
const List<String> furnitureIncluded = [
  'wardrobe',
  'chair',
  'table',
  'sofa',
  'drawer',
  'kitchen',
  'bed'
];

bool getPriceIncluded(String value, List<String> data) {
  if (data.contains(value)) {
    return true;
  } else {
    return false;
  }
}

bool getFurniture(String value, List<String> data) {
  if (data.contains(value)) {
    return true;
  } else {
    return false;
  }
}

String getHeating(String value) {
  switch (value) {
    case 'central':
      return 'Төвийн';
    case 'electric':
      return 'Цахилгаан';
    case 'pressure':
      return 'Нам даралт';
    case 'furnace':
      return 'Пийшин';
    default:
      return '';
  }
}

String getWaterSupply(String value) {
  switch (value) {
    case 'central':
      return 'Төвийн';
    case 'well':
      return 'Гүний худаг';
    case 'portable':
      return 'Зөөврийн';
    default:
      return '';
  }
}

String getToilet(String value) {
  switch (value) {
    case 'inside':
      return 'Дотроо';
    case 'outside':
      return 'Гаднаа';
    case 'public':
      return 'Нийтийн';
    default:
      return '';
  }
}
