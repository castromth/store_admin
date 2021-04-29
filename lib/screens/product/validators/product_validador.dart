class ProductValidator {


  String validateTitle(String text){
    if(text.isEmpty) return "Preencha o titulo do produto";
    return null;
  }


  String validadeMarca(String text){
    if(text.isEmpty) return "Preencha a marca do produto";
    return null;
  }

  String validateSizes(List l){
    print(l);
    if(l.isEmpty) return " ";
    return null;
  }
  String validadePrice(String text){
    double price = double.tryParse(text);
    if(price != null){
      if(!text.contains(".") || text.split(".")[1].length != 2)
        return "Ultilize 2 casas decimais";
    }else {
      return "Numero invalido";
    }
    return null;
  }

  String validadeImages(List images){
    if(images.isEmpty) return "Adicione images do produto";
    return null;
  }
}