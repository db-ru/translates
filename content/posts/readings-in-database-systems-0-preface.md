---
title: "Readings in Database Systems. 0. Предисловие"
summary: "Readings in Database Systems (широко известная как 'Red book')
предлагает читателям своевольный взгляд как на классические, так и на
передовые исследования в области управления данными с 1988 года. Здесь
представлено пятое издание - первое за последние десять лет (2015)."
date: 2020-07-11T20:09:43+03:00
draft: false
categories:
- readings in database systems
- red book
- Peter Bailis
- Joseph M. Hellerstein
- Michael Stonebraker
---

За десять лет, прошедших со времени предыдущего издания «Readings in Database
Systems», область управления данными расширилась. Сегодня базы данных и системы
с интенсивным использованием данных работают с беспрецедентными объемами данных,
чему во многом способствует рост «больших данных» и значительное снижение
стоимости их хранения и вычислений. Облачные вычисления и микроархитектурные
тенденции сделали распределённость и параллелизм почти повсеместными проблемами.
Данные собираются из растущего разнообразия разнородных форматов и источников в
возрастающем объеме и используются для постоянно растущего диапазона задач.
В результате базы данных значительно эволюционировали по
нескольким параметрам: от использования новых носителей данных и конструкций
процессоров до архитектур обработки запросов, интерфейсов программирования и
новых требований приложений как в обработке транзакций, так и в аналитике. Это
захватывающее время со значительной встряской на рынке и множеством новых идей
из исследований.

В это время быстрых изменений, наше обновление традиционной «Красной книги»
("Red book") призвано дать как основу для основных концепций в данной
области, так и комментарии к отдельным трендам. Некоторые новые технологии имеют
поразительное сходство с предшественниками прошлых десятилетий, и мы считаем,
что нашим читателям было бы полезно ознакомиться с первоисточниками. В то же
время технологические тенденции вынуждают переоценить практически все измерения
баз данных, и многие классические дизайны систем нуждаются в пересмотре. Наша
цель в этом сборнике - раскрыть важные долгосрочные уроки и основополагающие
разработки и выделить те новые идеи, которые мы считаем наиболее новаторскими
и актуальными.

Соответственно, мы выбрали сочетание классических, традиционных статей из ранней
литературы по базам данных, а также статей, которые оказали наибольшее влияние
на последние разработки, включая обработку транзакций, обработку запросов,
расширенную аналитику, веб-данные и языковой дизайн. В каждую главу мы
включили краткий комментарий, представляющий статьи и объясняющий, почему мы
выбрали каждую из них. Каждый комментарий написан одним из редакторов, но все
редакторы внесли свой вклад; мы надеемся, что комментарии не лишены мнения.

При отборе материалов мы искали темы и документы, отвечающие основному набору
критериев. Во-первых, каждый выбор представляет собой основную тенденцию в
управлении данными, о чем свидетельствуют как исследовательский интерес, так и
рыночный спрос. Во-вторых, каждый выбор является каноническим или почти
каноническим; мы искали наиболее представительный документ по каждой теме.
В-третьих, каждый выбор является первоисточником. Есть хорошие обзоры по многим
темам в этом сборнике, на которые мы ссылаемся в комментариях. Тем не менее,
чтение первоисточников предоставляет исторический контекст и даёт читателю
представление о том, что именно сформировало влиятельные решения, и помогает
гарантировать, что наши читатели хорошо подкованы в этой области. Наконец, эта
коллекция представляет наше нынешнее понимание того, что является «самым важным»;
мы ожидаем, что наши читатели будут критически оценивать эту коллекцию.

Одним из основных отклонений от предыдущих выпусков «Красной книги» является то,
как мы относились к последним двум разделам: аналитика и интеграция данных. Как
в исследованиях, так и на рынке ясно, что это две самые большие проблемы в
управлении данными сегодня. Они также являются быстро развивающимися темами как
в исследованиях, так и на практике. Учитывая это состояние, нам было трудно
договориться о «канонических» материалах по этим темам. В сложившихся
обстоятельствах мы решили пропустить официальные документы, а вместо этого
предложить комментарий. Это, очевидно, приводит к предвзятому мнению о том, что
происходит в этой области. Поэтому мы не рекомендуем эти разделы в качестве
«обязательного чтения», которое традиционно пыталась предложить «Красная книга».
Вместо этого мы рассматриваем их как необязательный конечный вопрос: «Искажённые
представления по движущимся целям». Читателям рекомендуется подойти к этим двум
разделам с некоторой долей скептицизма (большей, чем для остальной части книги).

Мы выпускаем эту редакцию «Красной книги» бесплатно, с разрешительной лицензией
на наш текст, которая позволяет неограниченное некоммерческое распространение в
нескольких форматах. Вместо того, чтобы защищать права на рекомендуемые статьи,
мы просто предоставили ссылки на поиски Google Scholar, которые должны помочь
читателю найти соответствующие документы. Мы ожидаем, что этот электронный
формат позволит делать более частые издания «книги». Мы планируем развивать
коллекцию по мере необходимости.

Последнее замечание: эта коллекция жива с 1988 года, и мы ожидаем, что у нее
будет долгая будущая жизнь. Соответственно, мы добавили немного «молодой крови»
к серо-бородым редакторам. При необходимости редакторы этого сборника могут со
временем развиваться дальше.


Peter Bailis

Joseph M. Hellerstein

Michael Stonebraker
