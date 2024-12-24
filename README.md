# Мобильное приложение "Потеряшки" для Android   

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

## Инструкция по запуску приложения 1  
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
9. Запустите приложение  
   `flutter run`  
## Инструкция по запуску приложения 2  


## Функционал приложения  
1. При запуске приложения пользователю представляется два варианта - войти в существующий аккаунт ил зарегистрироваться. Вход требует ввод имени пользователя и пароль.   
В случае выбора регистрации, новый пользователь должен дополнительно ввести имя пользователя, почту, номер телефона, пароль, затем повторить пароль и принять политику конфиденциальности.   

![Страница регистрации](https://github.com/Menelliss/Coursework/blob/flask_server/%20screenshot/1.jpg)   ![Страница регистрации_2](https://github.com/Menelliss/Coursework/blob/flask_server/%20screenshot/2.jpg)  

Проверяется правильность написания почты, номера телефона и соответствие заданных паролей. После войти в аккаунт.  

![Страница регистрации_3](https://github.com/Menelliss/Coursework/blob/flask_server/%20screenshot/3.jpg)  

2. Затем пользователь попадает на главную страницу приложения. Ему доступны 3 кнопки на нижней панели - "Главная", "Добавить объявление", " Мой профиль".   
На главной странице пользователь видит список опубликованных объявленийпотерянных и найденных вещей. Нажав на объявление найденной или потерянной вещи, пользователь открывает подробное описание к вещи и номер автора объявления с возможностью связи с ним.   

![Страница home](https://github.com/Menelliss/Coursework/blob/flask_server/%20screenshot/4.jpg)   

Пользователь воспользоваться кнопкой "Поиск" и найти объявление по словам-маркерам.  
![Страница home](https://github.com/Menelliss/Coursework/blob/flask_server/%20screenshot/5.jpg)   

3.  Кнопка "Добавить объявление" открывает окно создания объявления. Пользователь может выбрать какую вещь будет публиковать - найденную или потерянную. Шаблон требует заполнить название вещи, ее описание, информацию о месте, дате и примерном времени потери/находки.   

![Страница home](https://github.com/Menelliss/Coursework/blob/flask_server/%20screenshot/6.jpg)   ![Страница home](https://github.com/Menelliss/Coursework/blob/flask_server/%20screenshot/7.jpg)  ![Страница home](https://github.com/Menelliss/Coursework/blob/flask_server/%20screenshot/8.jpg)  

При вводе информации о месте и времени предлагаются окошки с удобным выбором.  
![Страница home](https://github.com/Menelliss/Coursework/blob/flask_server/%20screenshot/9.jpg)  ![Страница home](https://github.com/Menelliss/Coursework/blob/flask_server/%20screenshot/10.jpg)  

4. В странице "Мой профиль" пользователь может изменить аватар аккаунта, из предложенных ему, сменить почту и пароль, а также выйти из аккаунта.  

![Страница home](https://github.com/Menelliss/Coursework/blob/flask_server/%20screenshot/11.jpg)  ![Страница home](https://github.com/Menelliss/Coursework/blob/flask_server/%20screenshot/12.jpg)  ![Страница home](https://github.com/Menelliss/Coursework/blob/flask_server/%20screenshot/13.jpg)  

## Авторы   
Николаева Елизавета Олеговна 4217  
Митрофанов Дмитрий Сергеевич 4217  
Матренина Елизавета Александровна 4217  
