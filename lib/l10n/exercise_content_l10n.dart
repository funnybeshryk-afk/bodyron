import 'package:flutter/widgets.dart';

import '../models/exercise_definition.dart';

/// Локализованные название, советы по технике и частая ошибка для
/// встроенных упражнений (см. [ExerciseLibrary.builtIn]). Английские
/// значения на [ExerciseDefinition] (name/tips/commonMistake) остаются
/// внутренним каноническим ключом — используются для сопоставления с
/// программами тренировок ([ProgramExercise.exerciseName]) и как запасной
/// вариант для английского интерфейса. Здесь — то, что реально видит
/// пользователь на ru/uz. Тот же паттерн, что [MuscleGroupL10n] для групп
/// мышц, просто с более объёмным содержимым.
///
/// Пользовательские упражнения (isCustom) никогда не попадают в эти карты —
/// это контент, который ввёл сам пользователь, переводить его нечем.
class ExerciseContent {
  final String name;
  final List<String> tips;
  final String commonMistake;

  const ExerciseContent({
    required this.name,
    required this.tips,
    required this.commonMistake,
  });
}

const Map<String, ExerciseContent> _ruExerciseContent = {
  'Bench Press': ExerciseContent(
    name: 'Жим штанги лёжа',
    tips: [
      'Держи лопатки сведёнными и опущенными на протяжении всего движения.',
      'Опускай штангу на середину груди подконтрольно, не отбивай её от груди.',
      'Сохраняй небольшой прогиб в пояснице, стопы полностью на полу.',
    ],
    commonMistake:
        'Разведение локтей до 90° перегружает плечи — держи угол ближе к 45–75°.',
  ),
  'Incline Bench Press': ExerciseContent(
    name: 'Жим штанги на наклонной скамье',
    tips: [
      'Выстави наклон скамьи 15–30° — при большем угле это превращается в жим на плечи.',
      'Опускай штангу к верху груди, чуть ниже ключиц.',
      'Держи запястья строго над локтями.',
    ],
    commonMistake:
        'Слишком крутой наклон смещает нагрузку на передние дельты вместо верха груди.',
  ),
  'Dumbbell Fly': ExerciseContent(
    name: 'Разведение гантелей лёжа',
    tips: [
      'Держи небольшой фиксированный угол в локтях на протяжении всего движения.',
      'Опускай гантели по широкой дуге, пока не почувствуешь растяжение груди.',
      'Своди гантели усилием груди над грудью, а не над лицом.',
    ],
    commonMistake:
        'Сгибание и разгибание локтей во время повторения превращает разведение в жим.',
  ),
  'Deadlift': ExerciseContent(
    name: 'Становая тяга',
    tips: [
      'Держи гриф близко к голеням и бёдрам на протяжении всего подъёма.',
      'Напряги корпус и держи спину нейтральной — не округляй поясницу.',
      'Сначала оттолкнись ногами от пола, потом тяни спиной.',
      'Выпрямись наверху за счёт ягодиц, не переразгибай поясницу.',
    ],
    commonMistake:
        'Уход грифа вперёд от тела перекладывает нагрузку на поясницу.',
  ),
  'Pull Up': ExerciseContent(
    name: 'Подтягивания',
    tips: [
      'Начинай из полного виса с расслабленными лопатками.',
      'Тяни грудь к перекладине, направляя локти вниз и назад.',
      'Контролируй опускание, а не падай вниз.',
    ],
    commonMistake:
        'Использование раскачки (кипинга) вместо строгой техники сокращает амплитуду.',
  ),
  'Barbell Row': ExerciseContent(
    name: 'Тяга штанги в наклоне',
    tips: [
      'Наклонись в тазобедренных суставах с прямой спиной, примерно на 45° к полу.',
      'Тяни штангу к низу рёбер, а не к подбородку.',
      'Держи корпус напряжённым, чтобы туловище не раскачивалось на каждом повторении.',
    ],
    commonMistake:
        'Слишком вертикальное положение превращает тягу в шраги вместо упражнения на спину.',
  ),
  'Lat Pulldown': ExerciseContent(
    name: 'Тяга верхнего блока',
    tips: [
      'Хват чуть шире плеч, корпус отклоняй назад совсем немного.',
      'Тяни рукоять к верху груди, ведя локтями.',
      'Не рывками тела дёргай вес вниз.',
    ],
    commonMistake:
        'Тяга рукояти за голову нагружает плечи без дополнительной пользы.',
  ),
  'Squat': ExerciseContent(
    name: 'Приседания со штангой',
    tips: [
      'Держи грудь приподнятой и корпус напряжённым на протяжении всего приседа.',
      'Разводи колени по линии носков.',
      'Приседай минимум до параллели — складка бедра должна опуститься ниже колена.',
      'Отталкивайся всей стопой, а не только пятками или носками.',
    ],
    commonMistake:
        'Заваливание коленей внутрь под нагрузкой увеличивает риск травмы коленей.',
  ),
  'Leg Press': ExerciseContent(
    name: 'Жим ногами',
    tips: [
      'Держи поясницу прижатой к спинке — не позволяй тазу отрываться от неё.',
      'Опускай платформу, пока колени не достигнут примерно 90°, не выходя за комфортную амплитуду.',
      'Толкай всей стопой, а не только носками.',
    ],
    commonMistake:
        'Слишком глубокое опускание с отрывом поясницы от спинки перекладывает нагрузку на позвоночник.',
  ),
  'Romanian Deadlift': ExerciseContent(
    name: 'Румынская тяга',
    tips: [
      'Начни с небольшого сгиба в коленях и сохраняй его неизменным на протяжении движения.',
      'Отводи таз назад, а не вниз, опуская штангу.',
      'Держи штангу близко к ногам — она должна почти касаться голеней.',
      'Останавливайся, когда почувствуешь сильное растяжение бицепса бедра, обычно на уровне середины голени.',
    ],
    commonMistake:
        'Округление поясницы ради большей амплитуды вместо остановки там, где позволяют мышцы задней поверхности бедра.',
  ),
  'Walking Lunge': ExerciseContent(
    name: 'Выпады в ходьбе',
    tips: [
      'Делай шаг достаточной длины, чтобы переднее колено оставалось за линией носка.',
      'Опускайся, пока заднее колено слегка не коснётся пола или не зависнет прямо над ним.',
      'Держи корпус вертикально на протяжении каждого шага.',
    ],
    commonMistake:
        'Слишком короткий шаг выводит переднее колено далеко за носок и перегружает его.',
  ),
  'Overhead Press': ExerciseContent(
    name: 'Жим штанги стоя',
    tips: [
      'Напряги корпус и ягодицы, чтобы избежать прогиба в пояснице.',
      'Жми штангу по прямой линии, слегка отводя голову назад, чтобы дать ей пройти.',
      'Заканчивай движение со штангой строго над плечами, а не перед собой.',
    ],
    commonMistake:
        'Чрезмерный прогиб поясницы, помогающий штанге пройти мимо лица, превращает жим в упражнение на поясницу.',
  ),
  'Lateral Raise': ExerciseContent(
    name: 'Разведение гантелей в стороны',
    tips: [
      'Поднимай гантели примерно до уровня плеч, не выше.',
      'Веди локтями, сохраняя небольшой изгиб на протяжении движения.',
      'Используй вес легче, чем кажется «строгим» — это упражнение не прощает раскачку.',
    ],
    commonMistake:
        'Раскачивание веса бёдрами и трапециями вместо работы средних дельт.',
  ),
  'Face Pull': ExerciseContent(
    name: 'Тяга к лицу',
    tips: [
      'Тяни канат к лицу, целясь на уровень глаз.',
      'Широко разводи локти в стороны и разворачивай кисти большими пальцами назад.',
      'Своди лопатки в конце каждого повторения.',
    ],
    commonMistake:
        'Слишком большой вес превращает движение в нижнюю тягу вместо упражнения на задние дельты и вращательную манжету.',
  ),
  'Barbell Curl': ExerciseContent(
    name: 'Подъём штанги на бицепс',
    tips: [
      'Держи локти прижатыми к корпусу на протяжении всего подъёма.',
      'Поднимай штангу без раскачки корпуса и таза.',
      'Опускай штангу подконтрольно на всей амплитуде.',
    ],
    commonMistake:
        'Использование раскачки тела для заброса веса вместо строгого подъёма.',
  ),
  'Hammer Curl': ExerciseContent(
    name: 'Молотковый подъём на бицепс',
    tips: [
      'Держи ладони обращёнными друг к другу (нейтральный хват) на протяжении всего движения.',
      'Держи локти близко к корпусу и неподвижными.',
      'Контролируй опускание — не давай весу просто падать.',
    ],
    commonMistake:
        'Смещение локтей вперёд превращает подъём на бицепс в подъём перед собой.',
  ),
  'Triceps Pushdown': ExerciseContent(
    name: 'Разгибание рук на блоке',
    tips: [
      'Держи локти прижатыми к корпусу на протяжении всего подхода.',
      'Полностью разгибай руки внизу, не выпрямляя локти резко и с усилием.',
      'Контролируй возврат — не давай рукояти резко отскакивать наверх.',
    ],
    commonMistake:
        'Отведение локтей от корпуса подключает плечи вместо трицепса.',
  ),
  'Plank': ExerciseContent(
    name: 'Планка',
    tips: [
      'Держи прямую линию от плеч до лодыжек.',
      'Напряги корпус так, будто готовишься к удару в живот.',
      'Держи ягодицы в напряжении, чтобы таз не провисал.',
    ],
    commonMistake:
        'Провисание или задирание таза снимает нагрузку с корпуса и перекладывает её на поясницу.',
  ),
  'Hanging Leg Raise': ExerciseContent(
    name: 'Подъём ног в висе',
    tips: [
      'Висите на полном хвате, избегая лишней раскачки.',
      'Подкручивай таз вверх, поднимая ноги, а не просто раскачивай их.',
      'Опускай ноги подконтрольно, а не давай им падать.',
    ],
    commonMistake:
        'Использование раскачки для заброса ног вместо контроля движения прессом.',
  ),
  'Cable Crunch': ExerciseContent(
    name: 'Скручивания на блоке',
    tips: [
      'Встань на колени достаточно далеко от блока, чтобы канат оставался постоянно натянутым.',
      'Скручивайся, сгибая позвоночник, а не тяни руками или тазом.',
      'Держи таз относительно неподвижным — это движение сгибания позвоночника, а не тазобедренного сустава.',
    ],
    commonMistake:
        'Тяга руками и сгибание в тазобедренных суставах вместо скручивания позвоночника.',
  ),
};

const Map<String, ExerciseContent> _uzExerciseContent = {
  'Bench Press': ExerciseContent(
    name: 'Yotib jim',
    tips: [
      'Harakat davomida kurak suyaklarini orqaga va pastga tortilgan holda ushlab tur.',
      'Grifni koʻkrak oʻrtasiga nazorat ostida tushir, koʻkragingga urib tushirma.',
      'Belingda ozgina yoy saqla, tovoning toʻliq polda tursin.',
    ],
    commonMistake:
        'Tirsaklarni 90° ga ochish yelkani zoʻriqtiradi — burchakni 45–75° ga yaqin ushla.',
  ),
  'Incline Bench Press': ExerciseContent(
    name: 'Qiyalikda jim',
    tips: [
      'Skameykani 15–30° qiyalikka qoʻy — bundan tikroq boʻlsa, bu yelka jimiga aylanadi.',
      'Grifni koʻkrak yuqorisiga, oʻmrov suyagidan biroz pastga tushir.',
      'Bilaklaringni tirsaklaring tepasida toʻgʻri saqla.',
    ],
    commonMistake:
        'Juda tik qiyalik yukni koʻkrak yuqorisidan oldingi yelkaga siljitadi.',
  ),
  'Dumbbell Fly': ExerciseContent(
    name: 'Yotib gantellarni yoyish',
    tips: [
      'Harakat davomida tirsaklarda ozgina, oʻzgarmas bukilishni saqla.',
      'Gantellarni koʻkragingda choʻzilishni his qilguningcha keng yoy boʻylab tushir.',
      'Gantellarni koʻkrak kuchi bilan koʻkraging ustida qaytar, yuzing ustida emas.',
    ],
    commonMistake:
        'Takror davomida tirsaklarni bukish-yozish harakatni jimga aylantiradi.',
  ),
  'Deadlift': ExerciseContent(
    name: 'Stanovaya tortish',
    tips: [
      'Butun koʻtarish davomida grifni boldir va sonlaringga yaqin tut.',
      'Tanangni taranglashtir va umurtqangni neytral holda saqla — belingni dumaloqlantirma.',
      'Orqang bilan tortishdan oldin oyoqlaring bilan poldan itaril.',
      'Yuqorida dumbangni siqib toʻliq tik tur, ortiga haddan tashqari egilma.',
    ],
    commonMistake:
        'Grifning tanadan uzoqlashib oldinga siljishi harakatni belga asoslangan ogʻir mashqqa aylantiradi.',
  ),
  'Pull Up': ExerciseContent(
    name: 'Turnikda tortilish',
    tips: [
      'Kurak suyaklari boʻsh holda, toʻliq osilgan holatdan boshla.',
      'Tirsaklaringni pastga va orqaga yoʻnaltirib, koʻkragingni turnikka tort.',
      'Pastga tushishni nazorat qil, shunchaki tushib ketma.',
    ],
    commonMistake:
        'Qatʼiy nazorat oʻrniga inersiyadan (kiping) foydalanish harakat amplitudasini qisqartiradi.',
  ),
  'Barbell Row': ExerciseContent(
    name: 'Egilib grif tortish',
    tips: [
      'Toʻgʻri orqa bilan, polga taxminan 45° burchakda, tos boʻgʻimidan egil.',
      'Grifni pastki qovurgʻalaringga tort, iyagingga emas.',
      'Har bir takrorda tanang tebranmasligi uchun uni taranglashtirib tut.',
    ],
    commonMistake:
        'Juda tik turish tortishni orqa mashqi oʻrniga yelka koʻtarish (shrag)ga aylantiradi.',
  ),
  'Lat Pulldown': ExerciseContent(
    name: 'Yuqori blokdan tortish',
    tips: [
      'Yelkadan biroz kengroq tuting, tanangizni faqat ozgina orqaga egib turing.',
      'Rukoyatkani tirsaklaringizni yetaklab, koʻkrak yuqorisiga torting.',
      'Vaznni pastga tortish uchun tana inersiyasidan foydalanmang.',
    ],
    commonMistake:
        'Rukoyatkani boʻyin ortiga tortish qoʻshimcha foydasiz yelkani zoʻriqtiradi.',
  ),
  'Squat': ExerciseContent(
    name: 'Grif bilan choʻkish',
    tips: [
      'Choʻkish davomida koʻkragingni koʻtarilgan va tanangni taranglashtirilgan holda ushla.',
      'Tizzalaringni panjalaring chizigʻi boʻylab tashqariga yoʻnaltir.',
      'Kamida parallel holatgacha choʻk — son burmasi tizzadan pastga tushishi kerak.',
      'Faqat tovon yoki panjada emas, butun tovon bilan itaril.',
    ],
    commonMistake:
        'Yuklama ostida tizzalarning ichkariga qulashi tizza shikastlanish xavfini oshiradi.',
  ),
  'Leg Press': ExerciseContent(
    name: 'Oyoqni itarish',
    tips: [
      'Belingni suyanchiqqa yopishtirib tut — tosning undan ajralishiga yoʻl qoʻyma.',
      'Platformani tizzalar taxminan 90° ga yetguncha tushir, qulay amplitudadan oshib ketma.',
      'Faqat panjada emas, butun tovon bilan itaril.',
    ],
    commonMistake:
        'Juda chuqur tushish va belning suyanchiqdan ajralishi yukni umurtqa pogʻonasiga siljitadi.',
  ),
  'Romanian Deadlift': ExerciseContent(
    name: 'Rumin uslubidagi tortish',
    tips: [
      'Tizzalarda ozgina bukilishdan boshla va harakat davomida uni oʻzgarishsiz saqla.',
      'Grifni tushirar ekan, tosni pastga emas, orqaga suring.',
      'Grifni oyoqlaringga yaqin tut — u boldiringizga deyarli tegib turishi kerak.',
      'Son orqasida kuchli choʻzilishni his qilganda toʻxta, odatda boldir oʻrtasi darajasida.',
    ],
    commonMistake:
        'Son orqasi mushaklari ruxsat bergan nuqtada toʻxtash oʻrniga koʻproq amplituda uchun belni dumaloqlantirish.',
  ),
  'Walking Lunge': ExerciseContent(
    name: 'Qadam tashlab choʻkish',
    tips: [
      'Old tizzang panjang chizigʻidan oshmasligi uchun yetarlicha uzun qadam tashla.',
      'Orqa tizzang polga yengil tegguncha yoki tepasida osilib qolguncha pastga tush.',
      'Har bir qadam davomida tanangni tik tut.',
    ],
    commonMistake:
        'Juda qisqa qadam old tizzani panjadan ancha oldinga chiqarib, uni ortiqcha yuklaydi.',
  ),
  'Overhead Press': ExerciseContent(
    name: 'Bosh uzra jim',
    tips: [
      'Belingda yoy hosil boʻlishining oldini olish uchun tanangni taranglashtir va dumbangni siq.',
      'Grifni toʻgʻri chiziq boʻylab yuqoriga it, uni oʻtkazish uchun boshingni biroz orqaga ol.',
      'Harakatni grif yelkalaring tepasida, oldingda emas, tugallagin.',
    ],
    commonMistake:
        'Grifning yuz oldidan oʻtishiga yordam berish uchun belni ortiqcha egish jimni bel mashqiga aylantiradi.',
  ),
  'Lateral Raise': ExerciseContent(
    name: 'Gantellarni yon tomonga koʻtarish',
    tips: [
      'Gantellarni taxminan yelka balandligigacha koʻtar, undan yuqoriga emas.',
      'Tirsaklaring bilan yetaklab, harakat davomida ozgina bukilishni saqla.',
      'Oʻzingizga «qattiq» tuyulgandan yengilroq vazndan foydalaning — bu mashq inersiyani kechirmaydi.',
    ],
    commonMistake:
        'Vaznni yon deltalar oʻrniga tos va trapetsiya bilan tebratib koʻtarish.',
  ),
  'Face Pull': ExerciseContent(
    name: 'Yuzga tomon tortish',
    tips: [
      'Arqonni koʻz darajasiga moʻljallab, yuzingga tomon torting.',
      'Tirsaklaringni keng yoying va bosh barmoqlaringiz orqaga qarab turishi uchun kaftlaringizni buring.',
      'Har bir takror oxirida kurak suyaklaringizni bir-biriga torting.',
    ],
    commonMistake:
        'Ortiqcha vazndan foydalanish harakatni orqa delta va rotator mansheti mashqi oʻrniga past tortishga aylantiradi.',
  ),
  'Barbell Curl': ExerciseContent(
    name: 'Grif bilan bilak buklash',
    tips: [
      'Butun buklash davomida tirsaklaringni yonboshingga mahkamlab tur.',
      'Tanang yoki tosingni tebratmasdan grifni yuqoriga buk.',
      'Grifni toʻliq amplitudada nazorat ostida tushir.',
    ],
    commonMistake:
        'Vaznni qatʼiy buklash oʻrniga tana inersiyasi (tebranish) bilan yuqoriga uloqtirish.',
  ),
  'Hammer Curl': ExerciseContent(
    name: 'Bolgʻa uslubida bilak buklash',
    tips: [
      'Harakat davomida kaftlaringni bir-biriga qarab turgan holda (neytral tutish) saqla.',
      'Tirsaklaringni tanangga yaqin va qimirlamas holda tut.',
      'Pastga tushish bosqichini nazorat qil — vaznga shunchaki tushib ketishga yoʻl qoʻyma.',
    ],
    commonMistake:
        'Tirsaklarning oldinga siljishi bilak buklashni oldinga koʻtarishga aylantiradi.',
  ),
  'Triceps Pushdown': ExerciseContent(
    name: 'Triseps uchun blokdan itarish',
    tips: [
      'Butun yondashuv davomida tirsaklaringni yonboshingga mahkamlab tur.',
      'Pastda qoʻllaringni toʻliq yoz, tirsaklaringni keskin qattiq qulflab qoʻyma.',
      'Qaytishni nazorat qil — rukoyatkaning keskin yuqoriga otilishiga yoʻl qoʻyma.',
    ],
    commonMistake:
        'Tirsaklarning tanadan uzoqlashishi tricepsni emas, yelkani ishga soladi.',
  ),
  'Plank': ExerciseContent(
    name: 'Planka',
    tips: [
      'Yelkalardan toʻpiqlarga qadar toʻgʻri chiziqni saqla.',
      'Xuddi qoringga urish kutilayotgandek tanangni taranglashtir.',
      'Tos osilib qolmasligi uchun dumbangni taranglikda tut.',
    ],
    commonMistake:
        'Tosning osilib qolishi yoki koʻtarilib ketishi yukni tanadan olib, belga oʻtkazadi.',
  ),
  'Hanging Leg Raise': ExerciseContent(
    name: 'Osilib oyoq koʻtarish',
    tips: [
      'Toʻliq tutish bilan osilib, ortiqcha tebranishdan saqlan.',
      'Oyoqlaringni shunchaki tebratish oʻrniga, ularni koʻtarar ekan tosingni yuqoriga buk.',
      'Oyoqlaringni tushishiga yoʻl qoʻymasdan, nazorat ostida tushir.',
    ],
    commonMistake:
        'Harakatni qorin mushaklari bilan nazorat qilish oʻrniga oyoqlarni uloqtirish uchun inersiyadan foydalanish.',
  ),
  'Cable Crunch': ExerciseContent(
    name: 'Blokda qorinni burish',
    tips: [
      'Arqon doim tarang boʻlishi uchun blokdan yetarlicha uzoqlikda tizzalab oʻtir.',
      'Qoʻllaring yoki tosing bilan tortmasdan, umurtqangni bukib burish qil.',
      'Tosingni nisbatan qimirlatmay tut — bu tos boʻgʻimi emas, umurtqa bukilishi harakati.',
    ],
    commonMistake:
        'Umurtqani burish oʻrniga qoʻllar bilan tortish va tos boʻgʻimidan bukilish.',
  ),
};

/// Работает с "сырым" английским именем упражнения напрямую — то же имя,
/// что хранится как канонический ключ в [ExerciseDefinition.name] и во всех
/// местах, куда оно попадает после сохранения (история тренировок, личные
/// рекорды и т.д., см. [CompletedExercise]/[PersonalRecord] — там это уже
/// просто String, без исходного [ExerciseDefinition]). Пользовательские
/// названия упражнений естественным образом не совпадают ни с одним ключом
/// в картах ниже и возвращаются как есть.
extension ExerciseNameL10n on String {
  String displayExerciseName(BuildContext context) {
    switch (Localizations.localeOf(context).languageCode) {
      case 'ru':
        return _ruExerciseContent[this]?.name ?? this;
      case 'uz':
        return _uzExerciseContent[this]?.name ?? this;
      default:
        return this;
    }
  }
}

extension ExerciseL10n on ExerciseDefinition {
  ExerciseContent? _content(BuildContext context) {
    switch (Localizations.localeOf(context).languageCode) {
      case 'ru':
        return _ruExerciseContent[name];
      case 'uz':
        return _uzExerciseContent[name];
      default:
        return null;
    }
  }

  /// Локализованное название упражнения. Для пользовательских упражнений
  /// и для английского интерфейса — исходное [name].
  String displayName(BuildContext context) => name.displayExerciseName(context);

  /// Локализованные советы по технике, либо исходные английские/пустой
  /// список для пользовательских упражнений.
  List<String> displayTips(BuildContext context) => _content(context)?.tips ?? tips;

  /// Локализованная частая ошибка, либо исходная английская/пустая строка
  /// для пользовательских упражнений.
  String displayCommonMistake(BuildContext context) =>
      _content(context)?.commonMistake ?? commonMistake;
}
