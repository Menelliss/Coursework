# Мобильное приложение *"Потеряшки"* для Android   

Мобильное приложение, предназначенное для помощи пользователям в поиске утерянных вещей и их возвращении владельцам, с удобным функционалом создания карточек для описания находок.    

## Описание приложения  
Приложение предназначено для пользователей, которые потеряли свою вещь или нашли чужую.  
Пользователь может создать карточку (объявление) с одной из двух целей:  
- Уведомить о потерянной вещи.  
- Сообщить о найденной вещи.  
  
В карточке указываются следующие данные:  
- Наименование вещи (например, «Ключи от дома»).  
- Подробное описание (особые приметы, цвет, материал и т.д.).  
- Предполагаемое место и время потери или находки.

## Инструкция по запуску приложения №1 на Android Studio   
1. Клонируйте репозиторий.
   Выполните команду в терминале:   
    `https://github.com/Menelliss/Coursework.git` 
3. Установите  Flutter.
   Следуйте официальной инструкции по установке:  
   `https://docs.flutter.dev/get-started/install`  
5. Установите зависимости проекта.
   Выполните команду:  
   `flutter pub get`  
7. Запустите эмулятор или подключите физическое устройство.  
   Для эмулятора: настройте Android Virtual Device (AVD) через Android Studio.  
   Для физического устройства: включите отладку по USB и подключите устройство к компьютеру.  
9. Запустите приложение. Выполните команду:  
   `flutter run`
   
## Инструкция по запуску приложения №2 на Android устройств с версией выше 14  
1. Скачайте APK файл. Перейдите по ссылке `https://disk.yandex.ru/d/RJ1Wf0RHrDD1wA` и загрузите APK файл на ваше устройство.
2. Разрешите установку приложений из неизвестных источников.
3. Установите APK файл. Следуйте инструкциям на экране и дождитесь завершения установки.
4. Запустите приложение. После завершения установки нажмите *Открыть* или найдите иконку приложения на главном экране устройства.

## Инструкция по запуску приложения №3 на сайте  
1. Откройте сайт по ссылке `http://62.113.98.135/`.  
2. Согласитесь с переходом по внешней ссылке.  

## Функционал приложения  
1. При запуске приложения пользователю представляется два варианта - войти в существующий аккаунт или зарегистрироваться. Вход требует ввод имени пользователя и пароль.   
В случае выбора регистрации, новый пользователь должен дополнительно ввести имя пользователя, почту, номер телефона, пароль, затем повторить пароль и принять политику конфиденциальности.   
<p align="center">
  <img src="https://raw.githubusercontent.com/Menelliss/Coursework/refs/heads/flask_server/%20screenshot/1.jpg" alt="Скриншот 1" width="200">
  <img src="https://raw.githubusercontent.com/Menelliss/Coursework/refs/heads/flask_server/%20screenshot/2.jpg" alt="Скриншот 2" width="200">
</p> 

2. Проверяется правильность написания почты, номера телефона и соответствие заданных паролей. После войти в аккаунт.  
<p align="center">
  <img src="https://raw.githubusercontent.com/Menelliss/Coursework/refs/heads/flask_server/%20screenshot/3.jpg" alt="Скриншот 3" width="200">
</p>

3. Затем пользователь попадает на главную страницу приложения. Ему доступны 3 кнопки на нижней панели - *"Главная"*, *"Добавить объявление"*, *"Мой профиль"*.   
На главной странице пользователь видит список опубликованных объявлений потерянных и найденных вещей. Нажав на объявление найденной или потерянной вещи, пользователь открывает подробное описание к вещи и номер автора объявления с возможностью связи с ним.   
<p align="center">
  <img src="https://raw.githubusercontent.com/Menelliss/Coursework/refs/heads/flask_server/%20screenshot/4.jpg" alt="Скриншот 4" width="200">
</p>  

4. Пользователь может воспользоваться кнопкой *"Поиск"* и найти объявление по словам-маркерам.  
<p align="center">
  <img src="https://raw.githubusercontent.com/Menelliss/Coursework/refs/heads/flask_server/%20screenshot/5.jpg" alt="Скриншот 5" width="200">
</p>    

5. Кнопка *"Добавить объявление"* открывает окно создания объявления. Пользователь может выбрать какую вещь будет публиковать - найденную или потерянную. Шаблон требует заполнить название вещи, ее описание, информацию о месте, дате и примерном времени потери/находки.   
<p align="center">
  <img src="https://raw.githubusercontent.com/Menelliss/Coursework/refs/heads/flask_server/%20screenshot/6.jpg" alt="Скриншот 6" width="200">
  <img src="https://raw.githubusercontent.com/Menelliss/Coursework/refs/heads/flask_server/%20screenshot/7.jpg" alt="Скриншот 7" width="200">
  <img src="https://raw.githubusercontent.com/Menelliss/Coursework/refs/heads/flask_server/%20screenshot/8.jpg" alt="Скриншот 8" width="200">
</p>

6. При вводе информации о месте и времени предлагаются окошки с удобным выбором.  
<p align="center">
  <img src="https://raw.githubusercontent.com/Menelliss/Coursework/refs/heads/flask_server/%20screenshot/9.jpg" alt="Скриншот 8" width="200">
  <img src="https://raw.githubusercontent.com/Menelliss/Coursework/refs/heads/flask_server/%20screenshot/10.jpg" alt="Скриншот 10" width="200">
</p> 

7. В странице *"Мой профиль"* пользователь может изменить аватар аккаунта, из предложенных ему, сменить почту и пароль, а также выйти из аккаунта.  
<p align="center">
  <img src="https://raw.githubusercontent.com/Menelliss/Coursework/refs/heads/flask_server/%20screenshot/11.jpg" alt="Скриншот 11" width="200">
  <img src="https://raw.githubusercontent.com/Menelliss/Coursework/refs/heads/flask_server/%20screenshot/12.jpg" alt="Скриншот 12" width="200">
  <img src="https://raw.githubusercontent.com/Menelliss/Coursework/refs/heads/flask_server/%20screenshot/13.jpg" alt="Скриншот 13" width="200">
</p> 

## Авторы   
Николаева Елизавета Олеговна 4217  
Митрофанов Дмитрий Сергеевич 4217  
Матренина Елизавета Александровна 4217  
