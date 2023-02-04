
&НаКлиенте
Процедура СформироватьОтчет_ВОтдельномОкне(Команда)
	
	ТабДок = Новый ТабличныйДокумент;
	
	ЗаполнитьТабличныйДокумент(ТабДок);
	
	ТабДок.ОтображатьСетку     = Ложь;
	ТабДок.ОтображатьЗаголовки = Ложь;
	ТабДок.ТолькоПросмотр      = Истина;
	
	ТабДок.Показать();
	
КонецПроцедуры

&НаКлиенте
Процедура СформироватьОтчет_НаФорме(Команда)
	
	ЗаполнитьТабличныйДокумент(ТабДокНаФорме);
	
КонецПроцедуры


&НаСервереБезКонтекста
Процедура ЗаполнитьТабличныйДокумент(ТабДок)
	
	Макет = Отчеты.ОстаткиТоваров_ТабДок_НаОсновеМакета.ПолучитьМакет("Макет");
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПоступлениеТовары.Номенклатура,
	|	ПоступлениеТовары.Количество
	|ПОМЕСТИТЬ ВТОбъединение
	|ИЗ
	|	Документ.ПоступлениеТоваровИУслуг.Товары КАК ПоступлениеТовары
	|ГДЕ
	|	ПоступлениеТовары.Ссылка.Проведен
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	РеализацияТовары.Номенклатура,
	|	-РеализацияТовары.Количество
	|ИЗ
	|	Документ.РеализацияТоваровИУслуг.Товары КАК РеализацияТовары
	|ГДЕ
	|	РеализацияТовары.Ссылка.Проведен
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТОбъединение.Номенклатура,
	|	СУММА(ВТОбъединение.Количество) КАК Количество
	|ИЗ
	|	ВТОбъединение КАК ВТОбъединение
	|
	|СГРУППИРОВАТЬ ПО
	|	ВТОбъединение.Номенклатура";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	ОбластьПодвал = Макет.ПолучитьОбласть("Подвал");
	ОбластьШапкаТаблицы = Макет.ПолучитьОбласть("ШапкаТаблицы");
	ОбластьПодвалТаблицы = Макет.ПолучитьОбласть("ПодвалТаблицы");
	ОбластьДетальныхЗаписей = Макет.ПолучитьОбласть("Детали");
	
	ТабДок.Очистить();
	
	ОбластьЗаголовок.Параметры.Дата = Формат(ТекущаяДата(),"ДЛФ=DD");
	
	ТабДок.НачатьАвтогруппировкуСтрок();
	
	ТабДок.Вывести(ОбластьЗаголовок, 1);
	ТабДок.Вывести(ОбластьШапкаТаблицы);
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	НомерПП = 1;
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		ОбластьДетальныхЗаписей.Параметры.Заполнить(ВыборкаДетальныеЗаписи);
		ОбластьДетальныхЗаписей.Параметры.НомерПП = НомерПП;
		ТабДок.Вывести(ОбластьДетальныхЗаписей, 2);
		НомерПП = НомерПП + 1;
	КонецЦикла;
	
	ТабДок.ЗакончитьАвтогруппировкуСтрок();
	ТабДок.Вывести(ОбластьПодвалТаблицы);
	ТабДок.Вывести(ОбластьПодвал);
	
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА

	
КонецПроцедуры

