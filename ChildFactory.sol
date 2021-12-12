// Inside the create function, we use the "new" keyword to deploy the child contract

// In this pattern, we create a factory contract with a function that handles
// the creation of child contracts and we might also add other functions for
// efficient management of these contracts (e.g. looking for a specific contract or
// disabling a contract)
// see Remnote doc for detailed instructions, explanations

contract Factory{
     Child[] public children;
     uint disabledCount;

    event ChildCreated(address childAddress, uint data);

     function createChild(uint data) external{
       Child child = new Child(data, children.length);
       children.push(child);
       emit ChildCreated(address(child), data);
     }

     function getChildren() external view returns(Child[] memory _children){
       _children = new Child[](children.length- disabledCount);
       uint count;
       for(uint i=0;i<children.length; i++){
          if(children[i].isEnabled()){
             _children[count] = children[i];
             count++;
          }
        }
     }  

     function disable(Child child) external {
        children[child.index()].disable();
        disabledCount++;
     }
 
}
contract Child{
    uint data;
    bool public isEnabled;
    uint public index;
    constructor(uint _data,uint _index){
       data = _data;
       isEnabled = true;
       index = _index;
    }

    function disable() external{
      isEnabled = false;
    }
}
