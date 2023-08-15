// urls
import 'package:tureeslii/model/error_handler.dart';
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
List<FilterData> filterItemsIncludedFee = [
  FilterData(
      name: 'Байрны мөнгө',
      qry: 'apartment_fees',
      field: 'priceIncluded',
      op: 'LIKE'),
  FilterData(name: 'СӨХ', qry: 'cox', field: 'priceIncluded', op: 'LIKE'),
  FilterData(
      name: 'Цахилгаан', qry: 'electric', field: 'priceIncluded', op: 'LIKE'),
  FilterData(
      name: 'Интернет', qry: 'internet', field: 'priceIncluded', op: 'LIKE'),
];

List<FilterData> filterOther = [
  FilterData(
      name: 'Цахилгаан халаалт', op: "=", qry: 'electric', field: 'heating'),
  FilterData(name: 'Дотор 00', op: "=", qry: 'inside', field: 'restroom'),
  FilterData(name: 'Тавилгатай', op: "LIKE", qry: true, field: "hasFurniture"),
  FilterData(
      name: 'Гүний худаг', op: "LIKE", qry: 'well', field: 'waterSupply'),
  FilterData(name: 'Тагт', op: "=", qry: true, field: 'balcony'),
  FilterData(name: 'Цахилгаан шат', op: "=", qry: true, field: 'elevator'),
  FilterData(
      name: 'Угаалгын машин', op: "=", qry: true, field: 'washingMachine'),
  FilterData(name: 'Зуух', op: "=", qry: true, field: 'stove'),
  FilterData(name: 'Хөргөгч', op: "=", qry: true, field: 'refrigerator'),
  FilterData(
      name: 'Гал тогооны тавилга',
      op: "=",
      qry: true,
      field: 'kitchenFurniture'),
  FilterData(name: 'Интернет', op: "=", qry: true, field: 'wifi'),
  FilterData(name: 'Кабелын ТВ', op: "=", qry: true, field: 'tvCable'),
  FilterData(
      name: 'Эмэгтэй', op: "LIKE", qry: 'Female', field: 'acceptedTenants'),
  FilterData(
      name: 'Эрэгтэй', op: "LIKE", qry: "Male", field: 'acceptedTenants'),
  FilterData(
      name: 'Гэр бүл', op: "LIKE", qry: "family", field: 'acceptedGender'),
  FilterData(name: 'Тэжээвэр амьтан', op: "=", qry: true, field: 'petAllowed'),
  FilterData(name: 'Тамхи татах', op: "=", qry: true, field: 'smokingAllowed'),
  FilterData(name: 'Зочин урих', op: "=", qry: true, field: 'guestAllowed'),
];

const monthsValues = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

const filterVerification = ['Баталгаажсан', 'Онцлох'];

const filterFloor = ['1', '2-5', '5+'];
List<FilterData> paymentConditionValues = [
  FilterData(name: 'Бүгд', op: '=', field: "paymentTerm"),
  FilterData(name: '1 сар', op: '=', field: "paymentTerm", qry: "1_month"),
  FilterData(name: '3 сар', op: '=', field: "paymentTerm", qry: '3_month'),
  FilterData(name: '6 сар', op: '=', field: "paymentTerm", qry: '6_month'),
];
const collaterals = ['Барьцаагүй'];

// sort
List<SortData> sortValues = [
  SortData(
      dir: "price", name: 'Үнэ өсөхөөр', icon: iconIncreasePrice, field: 'ASC'),
  SortData(
      dir: "price",
      name: 'Үнэ буурахаар',
      icon: iconDecreasePrice,
      field: 'DESC'),
  SortData(
      dir: "startDate", name: 'Шинэ эхэндээ', icon: iconNewStart, field: 'ASC'),
  SortData(
      dir: "startDate",
      name: 'Хуучин эхэндээ',
      icon: iconNewStart,
      field: 'DESC'),
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
