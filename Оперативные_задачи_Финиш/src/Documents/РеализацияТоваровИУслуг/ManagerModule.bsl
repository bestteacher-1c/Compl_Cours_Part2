Процедура ПерепровестиРеализацииРасчетСебестоимости(Дата) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ЗаданияНаРасчетСебестоимости.Накладная
		|ИЗ
		|	РегистрСведений.ЗаданияНаРасчетСебестоимости КАК ЗаданияНаРасчетСебестоимости
		|ГДЕ
		|	ЗаданияНаРасчетСебестоимости.Накладная.Дата < &Дата
		|УПОРЯДОЧИТЬ ПО
		|	ЗаданияНаРасчетСебестоимости.Накладная.МоментВремени";
	
	Запрос.УстановитьПараметр("Дата", Дата);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		
		ДокОбъект = ВыборкаДетальныеЗаписи.Накладная.ПолучитьОбъект();

		ДокОбъект.ДополнительныеСвойства.Вставить("РасчетСебестоимости", Истина);

		ДокОбъект.Записать(РежимЗаписиДокумента.Проведение, РежимПроведенияДокумента.Неоперативный);

	КонецЦикла;
	

КонецПроцедуры