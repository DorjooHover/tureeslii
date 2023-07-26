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
