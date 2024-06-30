# Aleo-shopping_list
Програма на Aleo(мові Leo), яка дозволяє керувати списком покупок.
Прогарма дозволяє: створювати список покупок, додавати нові товари, відзначати товари як придбані та видаляти їх зі списку. 

 {

      program shopping_list_kx0d8ki.aleo {

    // Структура для представлення товару
    struct Item {
        name: field,
        quantity: u32
    }

    // Мапінг для збереження товарів у списку
    mapping items:
        key as field.public;   // Ідентифікатор товару
        value as Item.private; // Інформація про товар

    // Функція для додавання нового товару до списку
    transition add_item:
        input name as field.public;
        input quantity as u32.public;
        assert.gt quantity 0u32;
        // Хешуємо ім'я товару для отримання ключа
        hash.bhp256 name into id as field;
        // Створюємо новий товар
        let item = Item {
            name,
            quantity
        };
        
        // Зберігаємо товар у мапінгу
        
        set item into items[id];

    // Функція для видалення товару зі списку
    transition remove_item:
        input name as field.public;
        // Хешуємо ім'я товару для отримання ключа
        hash.bhp256 name into id as field;
        // Видаляємо товар за ключем
        delete items[id];

    // Функція для перевірки наявності товару у списку/
    
    function check_item:
        input name as field.public;
        // Хешуємо ім'я товару для отримання ключа
        hash.bhp256 name into id as field;
        // Перевіряємо наявність товару у мапінгу
        get.or_use items[id] Item { name: 0field, quantity: 0u32 } into item;
        output item as Item.private;

    //Функція для отримання всього списку покупок
    
    function get_list:
        // Отримуємо всі ключі мапінгу
        keys items into keys as [field];
        // Ініціалізуємо список для товарів
        let mut list = [];
        // Проходимо по всіх ключах
        for key in keys {
            // Отримуємо товар за ключем
            get items[key] into item;
            // Додаємо товар до списку
            push list item;
        }
        output list as [Item];

}

 



/////////////////////////////////////////////////////////

Офіційний сайт https://www.aleo.org/
Leo: https://leo-lang.org/
Discord https://discord.gg/aleohq
Twitter https://twitter.com/AleoHQ
GitHub https://github.com/AleoHQ
