# Reproducible_research
Course assignments
Проект посвящен воспроизведению анализа данных, представленых в статье Drozdova, P., Gurkov, A., Saranchina, A. et al. Transcriptional response of Saccharomyces cerevisiae to lactic acid enantiomers. Appl Microbiol Biotechnol 108, 121 (2024). https://doi.org/10.1007/s00253-023-12863-z
Краткое резюме статьи:
    В статье представлены исследования транскрипционного ответа штамма BY4742 S. cerevisiae на широкий диапазон концентраций DLA (от 0,05 до 45 мМ) и результаты сравнения его с ответом на 45 мМ L-молочную кислоту (LLA). Был зафиксирован ответ на 5 и 45 мМ DLA и менее выраженный ответ на 45 мМ LLA. 
    Не были выявлены естественные дрожжевые промоторы, количественно распознающие DLA, однако дано первое описание транскриптомного ответа на DLA и LLA. Некоторые гены, активируемые DLA, связаны с метаболизмом лактата, с поглощением железа и структурой клеточной стенки. 
    Дополнительно выявлено, что некоторые из генов активировались только кислой формой DLA, но не ее солью, что раскрывает роль pH. Список генов, реагирующих на LLA, был аналогичен опубликованным ранее и также включал гены поглощения железа и клеточной стенки и  гены, реагирующие на другие слабые кислоты. 

В разделе статьи Data analysis and availability указан номер доступа к данным секвенирования РНК в репозитории NCBI GEO: GSE231937.

Основные данные из NCBI были скачаны на удаленный сервер bioinformatics.isu.ru 
Для подключения локального устройства с ОС Windows к выделенному серверу с ОС Linux использовалась  утилита PuTTY.
Использованные команды:
# подключение к серверу под аккаунтом St_4
ssh -p 627 St_4@bioinformatics.isu.ru 
#указание пути исполняемого файла программы
export PATH=$PATH:/media/secondary/apps/sratoolkit.3.0.0-ubuntu64/bin/
#скачивание данных по реакции на 5 мМ D-лактата
fasterq-dump --threads 2 -A --progress SRR24466389; fasterq-dump --threads 2 -A --progress SRR24466390; fasterq-dump --threads 2 -A --progress SRR24466391; fasterq-dump --threads 2 -A --progress SRR24466380; fasterq-dump --threads 2 -A --progress 
SRR24466381; fasterq-dump --threads 2 -A --progress SRR24466382