# Задание к курсу "Методы воспроизводимых исследований в биологии"
## Воспроизведение анализа данных статьи
Проект посвящен воспроизведению анализа данных, представленых в статье:
Drozdova, P., Gurkov, A., Saranchina, A. et al. 
Transcriptional response of Saccharomyces cerevisiae to lactic acid enantiomers. 
Appl Microbiol Biotechnol 108, 121 (2024). 
https://doi.org/10.1007/s00253-023-12863-z
## Краткое резюме статьи:
        В статье представлены исследования транскрипционного ответа штамма BY4742 S. cerevisiae 
    на широкий диапазон концентраций DLA (от 0,05 до 45 мМ) и результаты сравнения его с 
    ответом на 45 мМ L-молочную кислоту (LLA). 
        Был зафиксирован ответ на 5 и 45 мМ DLA и менее выраженный ответ на 45 мМ LLA. 
    Не были выявлены естественные дрожжевые промоторы, количественно распознающие DLA, 
    однако дано первое описание транскриптомного ответа на DLA и LLA. Некоторые гены, 
    активируемые DLA, связаны с метаболизмом лактата, с поглощением железа и структурой 
    клеточной стенки. Дополнительно выявлено, что некоторые из генов активировались только
    кислой формой DLA, но не ее солью, что раскрывает роль pH. Список генов, реагирующих на LLA, 
    был аналогичен опубликованным ранее и также включал гены поглощения железа и клеточной стенки
    и  гены, реагирующие на другие слабые кислоты. 
## Графический абстракт
![abstract](https://github.com/user-attachments/assets/4c5c9723-7ead-49ab-8fde-c3d45c0f9581)
## Материалы и методы

В разделе статьи Data analysis and availability указан номер доступа к данным секвенирования РНК
в репозитории NCBI GEO: GSE231937.

### _скачивание данных на удаленный сервер_

Основные данные из NCBI были скачаны на удаленный сервер bioinformatics.isu.ru 
Для подключения локального устройства с ОС Windows к выделенному серверу с ОС Linux использовалась  утилита PuTTY.

_подключение к серверу под аккаунтом St_4_

ssh -p 627 St_4@bioinformatics.isu.ru 

_указание пути исполняемого файла программы_

export PATH=$PATH:/media/secondary/apps/sratoolkit.3.0.0-ubuntu64/bin/

_скачивание данных по реакции на 5 мМ D-лактата_

fasterq-dump --threads 2 -A --progress SRR24466389; 

fasterq-dump --threads 2 -A --progress SRR24466390; 

fasterq-dump --threads 2 -A --progress SRR24466391; 

fasterq-dump --threads 2 -A --progress SRR24466380; 

fasterq-dump --threads 2 -A --progress SRR24466381;

fasterq-dump --threads 2 -A --progress SRR24466382

### _визуализация данных_
Визуализация результатов осуществлялась при помощи R 4.3.3 и IDE RStudio 2024.09.0
# используемый код для визуализации и анализа
                library(ggplot2)
                library(ggpubr)
                library(openxlsx)
                library(DESeq2)
                library(EnhancedVolcano)
                #загрузка и чтение данных 
                data1 <-read.xlsx("253_2023_12863_MOESM2_ESM.xlsx",sheet = 3)
                data1$condition <- as.factor(data1$Condition)
                count_table <- read.delim("C:\\Users\\admin\\Downloads\\allSamples.featureCounts.txt", skip=1, row.names="Geneid")
                sample_table <- data.frame(condition=c("DL", "DL", "DL", "control", "control", 
                                                     "control"))
                # построение графика box-plot
                ggplot(data=data1,aes(x=condition,y=RGR2,fill = condition))+
                        geom_boxplot(outliers = FALSE,size=0.4,alpha = 0.1, color = "red")+
                        geom_jitter(aes(colour = condition),width = 0.1)+
                        ylab("Relaitive growth rate")+ xlab("")+
                        geom_pwc(method="wilcox_test", label ="p.adj")
                # анализ дифференциации экспрессии
                ddsFullCountTable <- DESeqDataSetFromMatrix(countData = count_table[,6:11], colData =       sample_table, design = ~ condition)
                dds <- DESeq(ddsFullCountTable)
                res <- results(dds)
                # построение графика volcano plot
                EnhancedVolcano(res, lab = rownames(res),
                                x = 'log2FoldChange', y = 'pvalue',
                                pCutoff=0.05, pCutoffCol = 'padj', FCcutoff = 1,
                                title="5mM DL vs. control", subtitle="",
                                col = c("grey30", "grey30", "grey30", "red2"),
                                xlab="", ylab = bquote(~-Log[10] ~ italic(p)),
                                caption="", selectLab = "", legendPosition = 'none')'


## _результаты_
Получили визуализированные результаты:

![Rplot](https://github.com/user-attachments/assets/87893792-dd13-4f0a-ac71-a76764065abc)
![Rplot 5DL vs control](https://github.com/user-attachments/assets/475e1dc2-4854-4c88-8c89-126b8da42239)

На графиках отображено: влияние Ph на рост и изменение экспрессии генов 
## Обсуждение
В оригинальной статье данные визуализированы следующим образом:

![image](https://github.com/user-attachments/assets/1d4a278a-e33c-4605-9d94-61d6702e0072)

![image](https://github.com/user-attachments/assets/a8ed9134-d827-40f1-a4e5-9db2c6ec706b)




## Заключение
В этом исследовании был изучен транскрипционный ответ S. cerevisiae к энантиомерам LA. 
Было обнаружено, что не было никакой реакции на концентрации DLA 0,5 мМ и ниже, а реакция 
на высокую онцентрацию DLA и LLA была довольно схожей и даже более выраженной для DLA, чем для LLA. 
Полученные результаты не позволяют использовать S. cerevisiae в качестве сенсора для DLA.

