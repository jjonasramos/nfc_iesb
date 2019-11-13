class Users {
  List<User> users;

  Users(List<User> users) {
    this.users = users;
  }

  List<User> getUsers() {
    return users;
  }

  User getUser(int index) {
    return users[index];
  }

  int getUsersSize() {
    return users.length;
  }
}

class User {
  String _nome;
  List<String> _id;
  int _matricula;
  String _curso;
  String _senha;
  String _device;
  String _imagem;

  User(String nome, List<String> id, int matricula, String curso ,String senha, String device, String deviceId,String imagem) {
    this._nome = nome;
    this._id = id;
    this._matricula = matricula;
    this._curso = curso;
    this._senha = senha;
    this._device = device;
    this._imagem = imagem;
  }

  String getDevice() {
    return _device;
  }

  void setDevice(String d) {
    _device = d;
  }

  void removeDevice(String d) {
    _device = null;
  }

  String getNome() {
    return _nome;
  }

  String getShortNome() {
    return _nome.split(' ')[0];
  }

  List<String> getListId() {
    return _id;
  }

  void removeItemListId() {
    _id.removeLast();
  }

  void addListId(String id) {
    _id.add(id);
  }

  int getListIdSize() {
    return _id.length;
  }

  String getCurso() {
    return _curso;
  }

  String getSenha() {
    return _senha;
  }

  int getMatricula() {
    return _matricula;
  }

  String getImage() {
    return _imagem;
  }
}