program shopping_list_kx0d8ki.aleo {

    
    struct Item {
        name: field,
        quantity: u32
    }

    
    mapping items:
        key as field.public;  
        value as Item.private; 

//
    transition add_item:
        input name as field.public;
        input quantity as u32.public;
        assert.gt quantity 0u32;
        
        hash.bhp256 name into id as field;
        
        let item = Item {
            name,
            quantity
        };
        
        set item into items[id];


    transition remove_item:
        input name as field.public;
       
        hash.bhp256 name into id as field;
       
        delete items[id];

    function check_item:
        input name as field.public;
       
        hash.bhp256 name into id as field;
        
        get.or_use items[id] Item { name: 0field, quantity: 0u32 } into item;
        output item as Item.private;




    function get_list:
        
        keys items into keys as [field];
        
        let mut list = [];
        
        for key in keys {
            
            get items[key] into item;
            
            push list item;
        }
        output list as [Item];
}
