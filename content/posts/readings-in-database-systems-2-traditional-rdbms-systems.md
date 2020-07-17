---
title: "Readings in Database Systems. Традиционные реляционные СУДБ"
date: 2020-07-13T17:32:31+03:00
summary: "В этом разделе представлены статьи (вероятно) о трёх наиболее важных
настоящих СУБД. Мы обсудим их в хронологическом порядке."
draft: true
categories:
- readings in database systems
- red book
- rdbms
- system r
- postgres
- gamma
---

# 2. Традиционные реляционные СУДБ

> Избранные статьи:
>
> - Morton M. Astrahan, Mike W. Blasgen, Donald D. Chamberlin, Kapali P.
>   Eswaran, Jim Gray, Patricia P. Griffiths, W. Frank King III,
>   Raymond A. Lorie, Paul R. McJones, James W. Mehl, Gianfranco R. Putzolu,
>   Irving L. Traiger, Bradford W. Wade, Vera Watson. System R: Relational
>   Approach to Database Management. ACM Transactions on Database Systems,
>   1(2), 1976, 97-137.
> - Michael Stonebraker and Lawrence A. Rowe. The design of POSTGRES. SIGMOD,
>   1986.
> - David J. DeWitt, Shahram Ghandeharizadeh, Donovan Schneider, Allan Bricker,
>   Hui-I Hsiao, Rick Rasmussen. The Gamma Database Machine Project. IEEE
>   Transactions on Knowledge and Data Engineering, 2(1), 1990, 44-62.

{{< param Summary >}}

Проект System R начался под руководством Фрэнка Кинга в IBM Research, вероятно,
примерно в 1972 году. К тому времени новаторской работе Теда Кодда было 18
месяцев, и для многих было очевидно, что нужно создать прототип, чтобы проверить
его идеи. К сожалению, Теду не разрешили возглавить эту работу, и он решил
рассмотреть естественные языковые интерфейсы для СУБД. System R быстро решила
внедрить SQL, который превратился из языка с чистой блочной структурой в 1972
году [34] в гораздо более сложную структуру, описанную в статье здесь [33]. См.
[46] для комментария о структуре языка SQL, написанного десятилетие спустя.

System R был разбит на две группы: «нижняя половина» и «верхняя половина». Они
не были полностью синхронизированы, так как нижняя половина реализовала ссылки,
которые не поддерживались верхней половиной. В защиту решения нижней половины
команды было ясно, что они конкурируют с IMS, у которой была такая же конструкция,
поэтому было естественно включить её. Верхняя половина просто не смогла заставить
оптимизатор работать для этой конструкции.

Менеджер транзакций, вероятно, является самым большим наследием проекта, и это
явно работа покойного Джима Грея. Большая часть его дизайна сохраняется и по сей
день в коммерческих системах. Второе место занимает оптимизатор System R.
Подход, основанный на стоимости, по-прежнему является золотым стандартом
для технологий оптимизаторов.

Моя самая большая претензия к System R состоит в том, что команда никогда не
прекращала дорабатывать SQL. Следовательно, когда «верхняя половина» была просто
приклеена к VSAM для формирования DB2, уровень языка оставался без изменений.
Все досадные черты языка сохранились до наших дней. SQL - это COBOL 2020 года,
язык, на котором мы застряли, на который все будут жаловаться.

Моя вторая по величине претензия заключается в том, что System R использовала
интерфейс вызова подпрограмм (сейчас ODBC) для подключения клиентского
приложения к СУБД. Я считаю ODBC одним из худших интерфейсов на планете. Чтобы
выполнить один запрос, нужно открыть базу данных, открыть курсор, связать его с
запросом, а затем выполнить отдельные чтения данных. Для выполнения одного
запроса требуется страница с довольно запутанным кодом. И у Энгра [150], и у
Криса Дейта [45] были намного более чистые языковые вложения. Более того,
Pascal-R [140] и Rigel [135] также были элегантными способами включить
функциональность СУБД в язык программирования. Только недавно, с появлением Linq
[115] и Ruby on Rails [80], мы наблюдаем возрождение более чистых языковых
встраиваний.

После System R Джим Грей отправился в Tandem для работы над Non-stop SQL, а
Kapali Eswaren сделал реляционный стартап. Большая часть команды осталась в IBM
и перешла к работе над другими проектами, включая R \*.

Вторая статья касается Postgres. Этот проект начался в 1984 году, когда стало
очевидно, что продолжать создавать прототипы с использованием академической
кодовой базы Ingres не имеет смысла. Подробная история Postgres появляется в
[147], и читатель направляется туда для полного подробного описания взлетов и
падений в процессе разработки.

Однако, на мой взгляд, важным наследием Postgres является его система
абстрактных типов данных (ADT). Пользовательские типы и функции были добавлены в
большинство основных реляционных СУБД с использованием модели Postgres.
Следовательно, эта конструктивная особенность сохраняется и по сей день. Проект
также экспериментировал с путешествиями во времени, но он работал не очень
хорошо. Я думаю, что хранилище без перезаписи ещё найдут свою нишу,
поскольку более быстрые технологии хранения данных меняет экономику управления
данными.

Следует также отметить, что бо́льшую часть вклада Postgres нужно связывать
с доступностью её надежного и производительного открытого исходного кода. Это
пример модели сообщества разработчиков с открытым исходным кодом в лучшем виде.
В середине 1990-х годов пикап-команда добровольцев взяла кодовую строку Беркли и
с тех пор занимается её развитием. И Postgres, и 4BSD Unix [112] сыграли важную
роль в том, чтобы сделать открытый исходный код предпочтительным механизмом для
разработки кода.

Проект Postgres продолжался в Беркли до 1992 года, когда была создана
коммерческая компания Illustra для поддержки коммерческой кодовой базы. См.
[147] описание взлетов и падений Illustra на рынке.

Помимо системы ADT и модели распространения с открытым исходным кодом, ключевым
наследием проекта Postgres было поколение высококвалифицированных разработчиков
СУБД, которые стали инструментом для создания нескольких других коммерческих
систем.

Третья система в этом разделе - Gamma, построенная в Висконсине в период между
1984 и 1990 годами. На мой взгляд, Gamma популяризировала подход с разделенными
таблицами без разделения ресурсов (shared-nothing) к многоузловому управлению
данными. Хотя у Teradata были одни и те же идеи параллельно, именно Gamma
популяризировала эти концепции. Кроме того, до Gamma никто не говорил о
хеш-соединениях (hash-join), поэтому следует отдать должное Gamma (вместе с
Кицурегава Масару) за разработку этого класса алгоритмов.

По сути, все системы хранилищ данных используют архитектуру в стиле Gamma. Любая
мысль об использовании общего диска или системы с общей памятью практически
исчезла. Если задержка сети и пропускная способность не будут сопоставимы с
пропускной способностью диска, я ожидаю, что текущая архитектура без совместного
использования ресурсов продолжится.