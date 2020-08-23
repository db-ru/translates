---
title: "Readings in Database Systems 5. Масштабируемые механизмы обратки данных"
date: 2020-08-23T12:52:58+03:00
summary: "Из многих разработок в области управления данными за последнее
десятилетие MapReduce и последующие крупномасштабные системы обработки данных
стали одними из самых пробивных и самых противоречивых. Низкая стоимость
хранения данных и их растущие объемы побудили многих поставщиков интернет-услуг
отказаться от традиционных баз данных и хранилищ, а вместо этого создать
свои собственные механизмы."
categories:
- readings in database systems
- red book
- map-reduce
- google file system
- dataflow engine
- Peter Bailis
draft: true
---

> Избранные статьи:
> 
> - Jeff Dean and Sanjay Ghemawat. MapReduce: Simplified Data Processing on
>   Large Clusters. OSDI, 2004.
> - Yuan Yu, Michael Isard, Dennis Fetterly, Mihai Budiu. DryadLINQ: A System for
>   General-Purpose Distributed Data-Parallel Computing Using a High-Level Language.
>   OSDI, 2008.
> 
> Автор: Michael Stonebraker

{{< param Summary >}}

Ряд публикаций Google об их крупномасштабных системах, включая Google File
System [^62], MapReduce, Chubby [^32] и BigTable [^37], возможно, самые
известные и влиятельные на рынке. Практически во всех случаях в этих новых
собственных системах реализовано небольшое подмножество функций обычных баз
данных, включая языки высокого уровня, оптимизаторы запросов и эффективные
стратегии выполнения. Однако эти системы и образовавшаяся экосистема Hadoop с
открытым исходным кодом оказались очень популярными у многих разработчиков.
Это привело к значительным инвестициям, маркетингу, исследовательскому интересу
и развитию этих платформ, которые сегодня постоянно меняются, но как экосистема
стали напоминать традиционные хранилища данных - с некоторыми важными
модификациями. Мы размышляем об этих тенденциях здесь.

## История и преемники {#history-and-successors}

Нашим первым чтением будет оригинальная статья Google MapReduce 2004 года.
MapReduce была библиотекой, созданной для упрощения параллельных распределенных
вычислений над распределенными данными в масштабе Google, в частности, для
пакетной перестройки индексов веб-поиска из просканированных страниц.
Маловероятно, что в то время традиционное хранилище данных могло справиться с
такой нагрузкой. Однако по сравнению с обычным хранилищем данных MapReduce
предоставляет интерфейс очень низкого уровня (двухэтапный поток данных,
two-stage dataflow), который тесно связан со стратегией отказоустойчивого
выполнения (промежуточная материализация между двухэтапным потоком данных).
Не менее важно, что MapReduce разрабатывался как библиотека для параллельного
программирования, а не как решение для комплексного хранилища данных; например,
MapReduce делегирует хранилище файловой системе Google (Google File System).
В то время члены сообщества баз данных осуждали данную архитектуру как упрощенную,
неэффективную и ограниченную в использовании [^53].

Хотя оригинальная статья о MapReduce была выпущена в 2003 году, до 2006 года,
когда Yahoo открыла исходный код реализации Hadoop MapReduce, не было практически
никакой активноcти вне Google. Впоследствии произошел взрыв интереса: в течение
года в разработке находился ряд проектов, включая Dryad (Microsoft) [^89], Hive
(Facebook) [^156], Pig (Yahoo) [^123]. Эти системы, которые мы будем называть
системами MapReduce, приобрели значительную популярность у разработчиков,
которые в основном были сконцентрированы в Кремниевой долине, а также привлекли
серьезные венчурные инвестиции. Множество исследований, охватывающих системы,
базы данных и сетевые сообщества, изучали вопросы, включая планирование,
устранение отставания, отказоустойчивость, оптимизацию запросов UDF и
альтернативные модели программирования [^16].

Практически сразу же пост-MapReduce системы расширили свой интерфейс и
функциональность, включив в них более сложные декларативные интерфейсы,
стратегии оптимизации запросов и эффективные среды выполнения. Сегодняшние
системы MapReduce начинают реализовывать всё большую часть набора функций
обычных СУБД. Последнее поколение движков обработки данных, таких как Spark
[^163], F1 [^143], Impala [^98], Tez [^1], Naiad [^119], Flink/Stratosphere [^9],
AsterixDB [^10] и Drill [^82] часто:
- предлагают языки запросов более высокого уровня, такие как SQL
- предлагают более продвинутые стратегии выполнения, включая возможность
  обработки общих графиков операторов
- используют индексы и другие функции источников структурированных входных
  данных (там, где возможно)
В экосистеме Hadoop механизмы потока данных стали основой для набора
высокоуровневых функций и декларативных интерфейсов, включая SQL [^15] [^156],
обработку графов [^64] [^110] и машинное обучение [^63] [^146].

Также растет интерес к функциональности потоковой обработки, пересматривая
многие концепции, впервые появившиеся в сообществе баз данных в 2000-х годах.
Растущие коммерческая и экосистема с открытым исходным кодом разработали
«соединители» для различных структурированных и полуструктурированных источников
данных, функций каталога (например, HCatalog), обслуживания данных и
ограниченных транзакционных возможностей (например, HBase). Большая часть этих
функций, таких как типичные оптимизаторы запросов в этих средах, являются
элементарными по сравнению со многими зрелыми коммерческими базами данных, но
быстро развиваются.

DryadLINQ, вторая выбранная статья для чтения этого раздела, возможно, наиболее
интересна своим интерфейсом: набором встроенных языковых привязок для обработки
данных, который легко интегрируется с Microsoft .NET LINQ для создания библиотеки
параллельных коллекций. DryadLINQ выполняет запросы через более раннюю систему
Dryad [^89], в которой реализована среда выполнения для произвольных графов
потока данных с использованием отказоустойчивости на основе воспроизведения.
Хотя DryadLINQ по-прежнему ограничивает программистов набором преобразований
наборов данных без побочных эффектов (включая «SQL-подобные» операции), он
предоставляет интерфейс значительно более высокого уровня, чем Map Reduce.
Языковая интеграция DryadLINQ, легкая отказоустойчивость и базовые методы
оптимизации запросов оказали влияние на более поздние системы обработки данных,
включая Apache Spark [^163] и Microsoft Naiad [^119].

## Вклад и наследение {#impact-and-legacy}


[^1]: Apache Tez. https://tez.apache.org/.

[^9]: A. Alexandrov, R. Bergmann, S. Ewen, J.-C. Freytag, F. Hueske, A. Heise, O.
Kao, M. Leich, U. Leser, V. Markl, et al. The Stratosphere platform for big
data analytics. The VLDB Journal, 23(6):939–964, 2014.

[^10]: S. Alsubaiee, Y. Altowim, H. Altwaijry, A. Behm, V. Borkar, Y. Bu, M.
Carey, I. Cetindil, M. Cheelangi, K. Faraaz, et al. Asterixdb: A scalable,
open source bdms. In VLDB, 2014.

[^15]: M. Armbrust, R. S. Xin, C. Lian, Y. Huai, D. Liu, J. K. Bradley, X. Meng,
T. Kaftan, M. J. Franklin, A. Ghodsi, et al. Spark SQL: Relational data
processing in spark. In SIGMOD, 2015.

[^16]: S. Babu and H. Herodotou. Massively parallel databases and MapReduce
systems. Foundations and Trends in Databases, 5(1):1–104, 2013.

[^32]: M. Burrows. The chubby lock service for loosely-coupled distributed
systems. In OSDI, 2006.

[^37]: F. Chang, J. Dean, S. Ghemawat, W. C. Hsieh, D. A. Wallach, M. Burrows,
T. Chandra, A. Fikes, and R. E.  Gruber. Bigtable: A distributed storage
system for structured data. In OSDI, 2006.

[^53]: D. DeWitt and M. Stonebraker. Mapreduce: A major step backwards. The
Database Column, 2008.

[^62]: S. Ghemawat, H. Gobioff, and S.-T. Leung. The google file system. In
SOSP, 2003.

[^63]: A. Ghoting, R. Krishnamurthy, E. Pednault, B. Reinwald, V. Sindhwani, S.
Tatikonda, Y. Tian, and S. Vaithyanathan. Systemml: Declarative machine
learning on mapreduce. In ICDE, 2011.

[^64]: J. E. Gonzales, R. S. Xin, D. Crankshaw, A. Dave, M. J. Franklin, and I.
Stoica. Graphx: Unifying data-parallel and graph-parallel analytics. In OSDI, 2014.

[^82]: M. Hausenblas and J. Nadeau. Apache Drill: Interactive ad-hoc analysis at
scale. Big Data, 1(2):100–104, 2013.

[^89]: M. Isard, M. Budiu, Y. Yu, A. Birrell, and D. Fetterly. Dryad:
distributed data-parallel programs from sequential building blocks. In EuroSys, 2007.

[^98]: M. Kornacker, A. Behm, V. Bittorf, T. Bobrovytsky, C. Ching, A. Choi, J.
Erickson, M. Grund, D. Hecht, M. Jacobs, et al. Impala: A modern, open-source
sql engine for hadoop. In CIDR, 2015.

[^110]: G. Malewicz, M. H. Austern, A. J. Bik, J. C. Dehnert, I. Horn, N.
Leiser, and G. Czajkowski. Pregel: a system for large-scale graph processing.
In SIGMOD, 2010.

[^119]: D. G. Murray, F. McSherry, R. Isaacs, M. Isard, P. Barham, and M. Abadi.
Naiad: A timely dataflow system.  In SOSP, 2013.

[^123]: C. Olston, B. Reed, U. Srivastava, R. Kumar, and A. Tomkins. Pig latin:
a not-so-foreign language for data processing. In SIGMOD, 2008.

[^143]: J. Shute, R. Vingralek, B. Samwel, B. Handy, C. Whipkey, E. Rollins, M.
Oancea, K. Littlefield, D. Menestrina, S. Ellner, et al. F1: A distributed sql
database that scales. In VLDB, 2013.

[^146]: E. R. Sparks, A. Talwalkar, V. Smith, J. Kottalam, X. Pan, J. Gonzalez,
M. J. Franklin, M. Jordan, T. Kraska, et al. Mli: An api for distributed
machine learning. In ICDM, 2013.

[^156]: A. Thusoo, J. S. Sarma, N. Jain, Z. Shao, P. Chakka, S. Anthony, H. Liu,
P. Wyckoff, and R. Murthy. Hive: A warehousing solution over a map-reduce
framework. In VLDB, 2009.

[^163]: M. Zaharia, M. Chowdhury, T. Das, A. Dave, J. Ma, M. McCauley, M. J.
Franklin, S. Shenker, and I. Stoica.  Resilient distributed datasets: A
fault-tolerant abstraction for in-memory cluster computing. In NSDI, 2012.
