import 'package:flutter/widgets.dart';

import '../models/training_article.dart';

/// Локализация обучающих статей (см. [TrainingArticles.all]). Английские
/// значения на [TrainingArticle] (title/category/paragraphs) остаются
/// внутренним каноническим контентом; здесь — то, что видит пользователь на
/// ru/uz. Тот же паттерн, что [MuscleGroupL10n], [ExerciseL10n] и
/// [ProgramL10n].
class ArticleContent {
  final String title;
  final List<String> paragraphs;

  const ArticleContent({required this.title, required this.paragraphs});
}

const Map<String, ArticleContent> _ruArticleContent = {
  'progressive_overload': ArticleContent(
    title: 'Прогрессивная перегрузка: основы',
    paragraphs: [
      'Прогрессивная перегрузка — самый важный принцип силовых тренировок: чтобы становиться сильнее, нужно постепенно увеличивать нагрузку на мышцы со временем.',
      'Самый простой способ применить его — добавлять немного веса на штангу, как только ты можешь уверенно выполнить все целевые подходы и повторения с хорошей техникой. Прибавка в 2,5 кг на базовом упражнении — это уже много: маленькие, но регулярные шаги лучше больших и нерегулярных.',
      'Если пока не можешь добавить вес, можно перегружать мышцы иначе: добавь повторение, добавь подход или замедли темп каждого повторения. Любой из этих вариантов делает подход тяжелее, чем в прошлый раз, — а это и есть суть прогрессии.',
      'Что НЕ считается прогрессом: погоня за более тяжёлыми весами в ущерб технике. Повторение, выполненное не в полной подконтрольной амплитуде, тренирует плохие привычки, а не силу.',
      'Smart Progression (PRO) в BODYRON отслеживает твои последние подходы по каждому упражнению и сама предлагает следующий вес и количество повторений — считать самому не придётся.',
    ],
  ),
  'rest_between_sets': ArticleContent(
    title: 'Сколько отдыхать между подходами?',
    paragraphs: [
      'Время отдыха между подходами зависит от цели тренировки. Для чистой силы в тяжёлых базовых упражнениях (присед, жим лёжа, становая тяга) 2–4 минуты позволяют нервной системе и мышцам восстановиться достаточно, чтобы снова поднять вес, близкий к максимальному.',
      'Для роста мышц (гипертрофии) с умеренными весами и большим числом повторений обычно хватает 60–90 секунд — важно поддерживать мышцу под нагрузкой в течение тренировки, не растягивая при этом сессию до бесконечности.',
      'Для небольших изолирующих упражнений вроде сгибаний на бицепс или разведений в стороны часто достаточно 30–60 секунд, поскольку суставы и стабилизаторы восстанавливаются быстрее, чем после тяжёлого приседа.',
      'Если тебе не хватает дыхания или следующий подход разваливается по качеству — скорее всего, ты отдохнул слишком мало. Если начинаешь остывать и терять концентрацию — отдохнул слишком много.',
      'Таймер отдыха в BODYRON по умолчанию ставит разумное значение, но его можно настроить под каждое упражнение в Настройках или прямо на экране тренировки.',
    ],
  ),
  'warming_up': ArticleContent(
    title: 'Почему важна разминка',
    paragraphs: [
      'Правильная разминка — это не про сжигание калорий, а про подготовку суставов, мышц и нервной системы к весу, который тебе предстоит поднять.',
      'Начни с нескольких минут лёгкого кардио или динамических движений, чтобы поднять температуру тела и усилить кровоток — особенно если тренируешься с самого утра.',
      'Затем сделай разминочные подходы для первого упражнения: лёгкий вес на несколько повторений, потом постепенно увеличивай вес, снижая количество повторений, пока не дойдёшь до рабочего веса. Для приседа со 100 кг это может выглядеть как 40 кг×8, 60 кг×5, 80 кг×3, а затем сразу рабочие подходы.',
      'Не нужно повторять весь этот разогрев для каждого упражнения, задействующего те же мышцы — обычно тело уже достаточно разогрето после первых одного-двух упражнений в тренировке.',
      'Пропуск разминки не только повышает риск травмы — первый рабочий подход часто ощущается тяжелее и менее стабильным, чем должен, просто потому что тело ещё не было готово.',
    ],
  ),
  'rep_ranges': ArticleContent(
    title: 'Как выбрать диапазон повторений',
    paragraphs: [
      'Диапазоны повторений — это ориентиры, а не строгие правила, но они полезны, чтобы сместить тренировку в сторону конкретной цели.',
      '1–5 повторений в подходе с тяжёлым весом — классический диапазон для развития максимальной силы: похоже на тренинг в стиле пауэрлифтинга на приседе, жиме и становой тяге.',
      '6–12 повторений — традиционный диапазон для гипертрофии (роста мышц): достаточно тяжело, чтобы нагрузить мышцу, и достаточно легко, чтобы набрать значимый объём за тренировку.',
      '13+ повторений развивает мышечную выносливость и часто используется для дополнительных или изолирующих упражнений вроде сгибаний на бицепс, разведений в стороны или упражнений на пресс.',
      'На практике большинство сбалансированных программ используют все три диапазона на разных упражнениях. Важнее всего — тренироваться близко к отказу (или отслеживать RPE) в выбранном диапазоне.',
    ],
  ),
  'rpe_and_failure': ArticleContent(
    title: 'RPE и тренировка до отказа',
    paragraphs: [
      'RPE (субъективная оценка усилия) — это шкала от 1 до 10, показывающая, насколько тяжёлым был подход. RPE 10 означает, что ты не смог бы сделать ещё одно повторение — настоящий мышечный отказ. RPE 8 означает, что в запасе, вероятно, оставалось ещё 2 повторения.',
      'Отслеживание RPE (или отметка подхода как «До отказа» в BODYRON) даёт тебе — и Smart Progression — гораздо более точную картину усилий, чем просто вес и повторения. Два подхода по 100 кг×5 могут быть совершенно разными тренировками в зависимости от того, насколько близко к отказу они выполнялись.',
      'Не обязательно доводить до отказа каждый подход, чтобы прогрессировать. Более того, делать это в каждом подходе каждой тренировки обычно накапливает усталость быстрее, чем наращивает силу.',
      'Разумный устойчивый подход: держать большинство подходов в диапазоне RPE 7–8 (оставляя в запасе 2–3 повторения) и приберегать настоящий отказ для последнего подхода упражнения, если вообще его использовать.',
      'Если записываешь подходы, не до конца понимая, что такое RPE, поможет простая проверка: смог бы ты сделать заметно больше повторений с хорошей техникой? Если да — это был не RPE 9–10.',
    ],
  ),
  'deload_week': ArticleContent(
    title: 'Когда нужна разгрузочная неделя',
    paragraphs: [
      'Разгрузочная неделя — это запланированная неделя со сниженной нагрузкой (более лёгкие веса, меньше подходов или и то и другое), которая даёт телу полностью восстановиться перед следующим тяжёлым тренировочным блоком.',
      'Это не признак слабости или отставания. Усталость накапливается быстрее, чем кажется большинству людей, и правильно спланированная разгрузка обычно делает тебя сильнее в последующие недели, а не слабее.',
      'Типичные признаки того, что пора: твои результаты застряли или снижаются 2–3 тренировки подряд, несмотря на старания, ты чувствуешь необычную измотанность, или суставы ноют, хотя явной травмы нет.',
      'Простой подход к разгрузке: оставь те же упражнения, но снизь рабочий вес примерно на 40–50% и количество подходов примерно вдвое на одну неделю. Каждый подход должен ощущаться так, будто ты едва работал.',
      'Определение плато в BODYRON отмечает упражнения, в которых твой лучший подход не улучшался 3 тренировки подряд — это хороший момент задуматься о разгрузке, прежде чем давить дальше.',
    ],
  ),
  'reading_smart_progression': ArticleContent(
    title: 'Как читать подсказки Smart Progression',
    paragraphs: [
      'Smart Progression (PRO) анализирует твои последние подходы по упражнению и предлагает вес и количество повторений на следующую тренировку — гадать не придётся.',
      'Если твой последний подход был на верхней границе диапазона повторений и близко к отказу, система обычно предложит немного увеличить вес, сбросив повторения к нижней границе диапазона — это классическая прогрессия «добавь вес, сбрось повторения».',
      'Если последний подход был крепким, но не на пределе, система может предложить остаться на том же весе и просто добавить повторение — это называется двойной прогрессией, более мягкий и очень устойчивый способ становиться сильнее.',
      'Если ты не выполнил целевое количество повторений, обычно будет предложено повторить тот же вес, а не двигаться дальше — повторить попытку не стыдно; постоянство важнее, чем натужный прогресс, которого пока нет.',
      'Эти подсказки — отправная точка, а не приказ. Твоя энергия, сон и стресс в конкретный день тоже важны — не стесняйся скорректировать вес вверх или вниз, ориентируясь на то, как ощущается первый подход.',
    ],
  ),
  'tracking_prs': ArticleContent(
    title: 'Как правильно отслеживать личные рекорды',
    paragraphs: [
      'BODYRON отслеживает личные рекорды по расчётному одноповторному максимуму (e1ПМ) — формуле, которая объединяет вес и повторения твоего лучшего подхода, чтобы оценить, сколько ты мог бы поднять на одно повторение.',
      'Это значит, что PR — не только про подъём самого тяжёлого веса за всё время: новый лучший подход 80 кг×8 может превзойти прежний рекорд 90 кг×3, потому что представляет большую расчётную силу в целом.',
      'PR засчитывается только для упражнения, которое ты выполнял минимум в двух разных тренировках, — так он отражает реальный прогресс во времени, а не один удачный день.',
      'Наблюдать, как твои PR растут неделями и месяцами, — куда более надёжный показатель силы, чем оценка любой отдельной тренировки: какие-то тренировки просто будут неудачными, и это нормально.',
      'Все свои текущие PR можно посмотреть на вкладке Прогресс вместе с датой, когда они были установлены, — это быстрый способ увидеть, какие упражнения застряли на месте и требуют внимания.',
    ],
  ),
};

const Map<String, ArticleContent> _uzArticleContent = {
  'progressive_overload': ArticleContent(
    title: 'Progressiv ortiqcha yuklama: asoslar',
    paragraphs: [
      'Progressiv ortiqcha yuklama — kuch mashqlarining eng muhim tamoyili: kuchliroq boʻlish uchun vaqt oʻtishi bilan mushaklaringizga tushadigan yukni asta-sekin oshirib borish kerak.',
      'Buni qoʻllashning eng oddiy yoʻli — barcha maqsad qilingan yondashuv va takrorlarni yaxshi texnika bilan bemalol bajara olganingizda grifga biroz vazn qoʻshishdir. Asosiy mashqda 2,5 kg qoʻshish yetarli — kichik, ammo barqaror qadamlar katta va notekis sakrashlardan yaxshiroq.',
      'Agar hali vazn qoʻsha olmasang, boshqa yoʻl bilan ham yuklamani oshirish mumkin: bitta takror qoʻsh, bitta yondashuv qoʻsh yoki har bir takrorning tempini sekinlashtir. Bularning har biri yondashuvni oldingisidan qiyinroq qiladi — ortiqcha yuklamaning mohiyati ham shu.',
      'Progress hisoblanmaydigan narsa: texnikani buzib, faqat ogʻirroq raqamlar ortidan quvish. Toʻliq nazorat ostida bajarilmagan takror kuchni emas, yomon odatni mustahkamlaydi.',
      'BODYRON’dagi Smart Progression (PRO) har bir mashq boʻyicha oxirgi yondashuvlaringizni kuzatib boradi va keyingi vazn hamda takror maqsadini oʻzi taklif qiladi — bu hisob-kitobni oʻzingiz qilishingiz shart emas.',
    ],
  ),
  'rest_between_sets': ArticleContent(
    title: 'Yondashuvlar orasida qancha dam olish kerak?',
    paragraphs: [
      'Yondashuvlar orasidagi dam olish vaqti nimaga mashq qilayotganingizga bogʻliq. Ogʻir bazaviy mashqlarda (skvot, jim, stanovaya tortish) sof kuch uchun 2–4 daqiqa asab tizimi va mushaklarga yana maksimalga yaqin vazn koʻtarish uchun yetarlicha tiklanish imkonini beradi.',
      'Oʻrtacha vazn va koʻp takror bilan mushak oʻsishi (gipertrofiya) uchun odatda 60–90 soniya yetarli — mashgʻulot davomida mushakni tarangligicha ushlab turish muhim, lekin seans cheksiz choʻzilib ketmasligi kerak.',
      'Bilak buklash yoki yon koʻtarish kabi kichik izolyatsion mashqlar uchun koʻpincha 30–60 soniya yetarli, chunki bogʻim va stabilizatorlar ogʻir skvotdan keyingiga qaraganda tezroq tiklanadi.',
      'Agar nafasingiz yetishmasa yoki keyingi yondashuv sifati buzilsa — ehtimol, kam dam oldingiz. Agar sovib ketib, diqqatingiz tarqalsa — ortiqcha dam oldingiz.',
      'BODYRON’dagi dam olish taymeri boshlangʻich holatda maqbul qiymatga sozlangan, lekin uni Sozlamalarda yoki toʻgʻridan-toʻgʻri mashgʻulot ekranida har bir mashq uchun alohida moslashtirish mumkin.',
    ],
  ),
  'warming_up': ArticleContent(
    title: 'Nega isinish muhim',
    paragraphs: [
      'Toʻgʻri isinish kaloriya yoqish uchun emas — u bogʻimlar, mushaklar va asab tizimini koʻtarmoqchi boʻlgan vazningizga tayyorlash uchun kerak.',
      'Ayniqsa ertalab mashq qilsangiz, tana harorati va qon aylanishini oshirish uchun bir necha daqiqa yengil kardio yoki dinamik harakatlardan boshlang.',
      'Keyin birinchi mashq uchun isinish yondashuvlarini bajaring: bir necha takror uchun yengil vazn, soʻng takrorlarni kamaytirib, vaznni asta-sekin oshirib boring, toki ish vazningizga yetguningizcha. 100 kg skvot uchun bu 40 kg×8, 60 kg×5, 80 kg×3, keyin esa toʻgʻridan-toʻgʻri ish yondashuvlari koʻrinishida boʻlishi mumkin.',
      'Xuddi shu mushaklarni ishga soladigan har bir mashq uchun bu toʻliq isinishni takrorlash shart emas — odatda tana mashgʻulotdagi birinchi bir-ikki mashqdan keyin allaqachon yetarlicha isigan boʻladi.',
      'Isinishni oʻtkazib yuborish nafaqat jarohat xavfini oshiradi — birinchi ish yondashuvi ham koʻpincha kutilganidan ogʻirroq va beqarorroq his qilinadi, chunki tana hali tayyor emas edi.',
    ],
  ),
  'rep_ranges': ArticleContent(
    title: 'Toʻgʻri takror oraligʻini tanlash',
    paragraphs: [
      'Takror oraligʻi qatʼiy qoida emas, balki yoʻnaltiruvchi mezon — ular mashgʻulotni aniq maqsad tomon yoʻnaltirishga yordam beradi.',
      'Ogʻir vazn bilan 1–5 takror — maksimal kuch rivojlantirish uchun klassik oraliq: bu pauerlifting uslubidagi skvot, jim va stanovaya tortish mashqlariga oʻxshaydi.',
      '6–12 takror — gipertrofiya (mushak oʻsishi) uchun anʼanaviy oraliq: mushakni yetarlicha yuklaydi va mashgʻulot davomida sezilarli hajm toʻplashga imkon beradi.',
      '13 va undan koʻp takror mushak chidamliligini rivojlantiradi va koʻpincha bilak buklash, yon koʻtarish yoki qorin mashqlari kabi qoʻshimcha yoki izolyatsion mashqlarda qoʻllaniladi.',
      'Amalda koʻpchilik muvozanatli dasturlar barcha uchta oraliqni turli mashqlarda qoʻllaydi. Eng muhimi — tanlagan oraligʻingizda charchashga yaqin ishlash (yoki RPE’ni kuzatib borish).',
    ],
  ),
  'rpe_and_failure': ArticleContent(
    title: 'RPE va charchaguncha mashq qilish',
    paragraphs: [
      'RPE (his qilingan zoʻriqish darajasi) — yondashuv qanchalik ogʻir kechganini koʻrsatadigan 1 dan 10 gacha shkala. RPE 10 — yana bitta takror qila olmasligingizni, yaʼni haqiqiy mushak charchashini bildiradi. RPE 8 esa, ehtimol, yana 2 ta takror uchun zaxirangiz qolganini bildiradi.',
      'RPE’ni yozib borish (yoki BODYRON’da yondashuvni «Toʻliq charchaguncha» deb belgilash) sizga — va Smart Progression’ga — vazn va takrordan koʻra sa’y-harakatingiz haqida ancha aniqroq tasavvur beradi. 100 kg×5 dan ikkita yondashuv, charchashga qanchalik yaqin bajarilganiga qarab, butunlay boshqa-boshqa mashgʻulot boʻlishi mumkin.',
      'Progress uchun har bir yondashuvni charchaguncha bajarish shart emas. Aksincha, buni har bir mashgʻulotning har bir yondashuvida qilish odatda kuchdan koʻra charchoqni tezroq toʻplaydi.',
      'Barqaror yondashuv: koʻpchilik yondashuvlarni RPE 7–8 oraligʻida ushlab turish (zaxirada 2–3 takror qoldirib) va haqiqiy charchashni, agar umuman ishlatilsa, mashqning oxirgi yondashuvi uchun saqlab qoʻyish.',
      'Agar RPE nima ekanini toʻliq tushunmasdan yondashuvlarni yozayotgan boʻlsangiz, oddiy tekshiruv yordam beradi: yaxshi texnika bilan sezilarli darajada koʻproq takror qila olarmidingiz? Agar ha boʻlsa, bu RPE 9–10 emas edi.',
    ],
  ),
  'deload_week': ArticleContent(
    title: 'Deload haftasini qachon olish kerak',
    paragraphs: [
      'Deload — bu rejalashtirilgan, yuklama kamaytirilgan hafta (yengilroq vazn, kamroq yondashuv yoki ikkalasi ham), bu tananing keyingi ogʻir mashgʻulot blokidan oldin toʻliq tiklanishiga imkon beradi.',
      'Bu ojizlik yoki orqada qolish belgisi emas. Charchoq koʻpchilik oʻylagandan tezroq toʻplanadi, va vaqtida qilingan deload odatda keyingi haftalarda sizni kuchliroq qiladi, zaifroq emas.',
      'Deload vaqti kelganining odatiy belgilari: yaxshi harakatlaringizga qaramay, natijalar 2–3 mashgʻulot davomida toʻxtab qolgan yoki pasaygan, oʻzingizni odatdan tashqari charchagan his qilasiz yoki jiddiy jarohat boʻlmasa-da, bogʻimlaringiz bezovta qiladi.',
      'Oddiy deload usuli: bir xil mashqlarni saqlab qoling, lekin bir hafta davomida ish vazningizni taxminan 40–50% ga va yondashuvlar sonini taxminan yarmiga kamaytiring. Har bir yondashuv sizga deyarli ishlamagandek his qilinishi kerak.',
      'BODYRON’dagi plato aniqlash tizimi eng yaxshi yondashuvingiz 3 mashgʻulot davomida yaxshilanmagan mashqlarni belgilaydi — bu yanada zoʻriqishdan oldin deload haqida oʻylab koʻrish uchun yaxshi fursat.',
    ],
  ),
  'reading_smart_progression': ArticleContent(
    title: 'Smart Progression tavsiyalarini qanday oʻqish kerak',
    paragraphs: [
      'Smart Progression (PRO) mashq boʻyicha oxirgi yondashuvlaringizni tahlil qiladi va keyingi mashgʻulot uchun vazn hamda takror maqsadini taklif qiladi — taxmin qilishga hojat qolmaydi.',
      'Agar oxirgi yondashuvingiz takror oraligʻining yuqori chegarasida va charchashga yaqin boʻlgan boʻlsa, tizim odatda vaznni biroz oshirib, takrorlarni oraliqning pastki chegarasiga tushirishni taklif qiladi — bu klassik «vazn qoʻsh, takrorni kamaytir» progressiyasi.',
      'Agar oxirgi yondashuv yaxshi, lekin chekka nuqtaga yetmagan boʻlsa, tizim shu vaznda qolib, shunchaki bitta takror qoʻshishni taklif qilishi mumkin — bu ikki bosqichli progressiya deb ataladi va kuchliroq boʻlishning yumshoqroq, ancha barqaror yoʻlidir.',
      'Agar takror maqsadiga yetmagan boʻlsangiz, tizim odatda oldinga siljish oʻrniga xuddi shu vaznni takrorlashni taklif qiladi — qayta urinishda uyat yoʻq; barqarorlik hali mavjud boʻlmagan progressni zoʻrlashdan koʻra muhimroq.',
      'Bu tavsiyalar boshlangʻich nuqta, buyruq emas. Kunlik energiyangiz, uyqu va stress ham muhim — birinchi yondashuv qanday his qilinishiga qarab vaznni yuqoriga yoki pastga moslashtirishdan tortinmang.',
    ],
  ),
  'tracking_prs': ArticleContent(
    title: 'Shaxsiy rekordlarni toʻgʻri kuzatish',
    paragraphs: [
      'BODYRON shaxsiy rekordlarni taxminiy bir takrorli maksimum (e1TM) orqali kuzatadi — bu eng yaxshi yondashuvingizning vazni va takrorini birlashtirib, bitta takror uchun qancha koʻtara olishingizni baholovchi formula.',
      'Bu shuni anglatadiki, PR faqat hayotingizdagi eng ogʻir vaznni koʻtarish haqida emas — 80 kg×8 dan iborat yangi eng yaxshi yondashuv 90 kg×3 dan iborat eski rekordni yengishi mumkin, chunki u umumiy taxminiy kuch jihatidan koʻproq narsani anglatadi.',
      'PR faqat kamida ikkita turli mashgʻulotda bajarilgan mashq uchun hisoblanadi — shunday qilib, u bir martalik yaxshi kun emas, balki vaqt oʻtishi bilan haqiqiy progressni aks ettiradi.',
      'PR’laringizning haftalar va oylar davomida oshib borishini kuzatish har qanday alohida mashgʻulotni baholashdan koʻra ancha yaxshiroq kuch koʻrsatkichidir — ayrim mashgʻulotlar shunchaki yomon kunlar boʻladi, va bu normal holat.',
      'Barcha joriy PR’laringizni Natija boʻlimida ular oʻrnatilgan sana bilan birga koʻrishingiz mumkin — bu qaysi mashqlar platoga tushib qolganini va yangi eʼtiborni talab qilayotganini tez aniqlash usuli.',
    ],
  ),
};

const Map<String, String> _ruArticleCategory = {
  'Fundamentals': 'Основы',
  'Intensity': 'Интенсивность',
  'Recovery': 'Восстановление',
  'BODYRON Features': 'Функции BODYRON',
};

const Map<String, String> _uzArticleCategory = {
  'Fundamentals': 'Asoslar',
  'Intensity': 'Intensivlik',
  'Recovery': 'Tiklanish',
  'BODYRON Features': 'BODYRON funksiyalari',
};

extension ArticleL10n on TrainingArticle {
  ArticleContent? _content(BuildContext context) {
    switch (Localizations.localeOf(context).languageCode) {
      case 'ru':
        return _ruArticleContent[id];
      case 'uz':
        return _uzArticleContent[id];
      default:
        return null;
    }
  }

  /// Локализованный заголовок статьи (ключ — [TrainingArticle.id]).
  String displayTitle(BuildContext context) => _content(context)?.title ?? title;

  /// Локализованные абзацы статьи.
  List<String> displayParagraphs(BuildContext context) =>
      _content(context)?.paragraphs ?? paragraphs;

  /// Локализованная категория статьи (например, "Fundamentals").
  String displayCategory(BuildContext context) {
    switch (Localizations.localeOf(context).languageCode) {
      case 'ru':
        return _ruArticleCategory[category] ?? category;
      case 'uz':
        return _uzArticleCategory[category] ?? category;
      default:
        return category;
    }
  }
}
