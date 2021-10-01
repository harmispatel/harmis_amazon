class GoogleAddressMaster {
  PlusCode _plusCode;
  List<Results> _results;
  String _status;

  GoogleAddressMaster({PlusCode plusCode, List<Results> results, String status}) {
    this._plusCode = plusCode;
    this._results = results;
    this._status = status;
  }

  PlusCode get plusCode => _plusCode;
  set plusCode(PlusCode plusCode) => _plusCode = plusCode;
  List<Results> get results => _results;
  set results(List<Results> results) => _results = results;
  String get status => _status;
  set status(String status) => _status = status;

  GoogleAddressMaster.fromJson(Map<String, dynamic> json) {
    _plusCode = json['plus_code'] != null
        ? new PlusCode.fromJson(json['plus_code'])
        : null;
    if (json['results'] != null) {
      _results = new List<Results>();
      json['results'].forEach((v) {
        _results.add(new Results.fromJson(v));
      });
    }
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._plusCode != null) {
      data['plus_code'] = this._plusCode.toJson();
    }
    if (this._results != null) {
      data['results'] = this._results.map((v) => v.toJson()).toList();
    }
    data['status'] = this._status;
    return data;
  }
}

class PlusCode {
  String _compoundCode;
  String _globalCode;

  PlusCode({String compoundCode, String globalCode}) {
    this._compoundCode = compoundCode;
    this._globalCode = globalCode;
  }

  String get compoundCode => _compoundCode;
  set compoundCode(String compoundCode) => _compoundCode = compoundCode;
  String get globalCode => _globalCode;
  set globalCode(String globalCode) => _globalCode = globalCode;

  PlusCode.fromJson(Map<String, dynamic> json) {
    _compoundCode = json['compound_code'];
    _globalCode = json['global_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['compound_code'] = this._compoundCode;
    data['global_code'] = this._globalCode;
    return data;
  }
}

class Results {
  List<AddressComponents> _addressComponents;
  String _formattedAddress;
  Geometry _geometry;
  String _placeId;
  PlusCode _plusCode;
  List<String> _types;

  Results(
      {List<AddressComponents> addressComponents,
        String formattedAddress,
        Geometry geometry,
        String placeId,
        PlusCode plusCode,
        List<String> types}) {
    this._addressComponents = addressComponents;
    this._formattedAddress = formattedAddress;
    this._geometry = geometry;
    this._placeId = placeId;
    this._plusCode = plusCode;
    this._types = types;
  }

  List<AddressComponents> get addressComponents => _addressComponents;
  set addressComponents(List<AddressComponents> addressComponents) =>
      _addressComponents = addressComponents;
  String get formattedAddress => _formattedAddress;
  set formattedAddress(String formattedAddress) =>
      _formattedAddress = formattedAddress;
  Geometry get geometry => _geometry;
  set geometry(Geometry geometry) => _geometry = geometry;
  String get placeId => _placeId;
  set placeId(String placeId) => _placeId = placeId;
  PlusCode get plusCode => _plusCode;
  set plusCode(PlusCode plusCode) => _plusCode = plusCode;
  List<String> get types => _types;
  set types(List<String> types) => _types = types;

  Results.fromJson(Map<String, dynamic> json) {
    if (json['address_components'] != null) {
      _addressComponents = new List<AddressComponents>();
      json['address_components'].forEach((v) {
        _addressComponents.add(new AddressComponents.fromJson(v));
      });
    }
    _formattedAddress = json['formatted_address'];
    _geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    _placeId = json['place_id'];
    _plusCode = json['plus_code'] != null
        ? new PlusCode.fromJson(json['plus_code'])
        : null;
    _types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._addressComponents != null) {
      data['address_components'] =
          this._addressComponents.map((v) => v.toJson()).toList();
    }
    data['formatted_address'] = this._formattedAddress;
    if (this._geometry != null) {
      data['geometry'] = this._geometry.toJson();
    }
    data['place_id'] = this._placeId;
    if (this._plusCode != null) {
      data['plus_code'] = this._plusCode.toJson();
    }
    data['types'] = this._types;
    return data;
  }
}

class AddressComponents {
  String _longName;
  String _shortName;
  List<String> _types;

  AddressComponents({String longName, String shortName, List<String> types}) {
    this._longName = longName;
    this._shortName = shortName;
    this._types = types;
  }

  String get longName => _longName;
  set longName(String longName) => _longName = longName;
  String get shortName => _shortName;
  set shortName(String shortName) => _shortName = shortName;
  List<String> get types => _types;
  set types(List<String> types) => _types = types;

  AddressComponents.fromJson(Map<String, dynamic> json) {
    _longName = json['long_name'];
    _shortName = json['short_name'];
    _types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['long_name'] = this._longName;
    data['short_name'] = this._shortName;
    data['types'] = this._types;
    return data;
  }
}

class Geometry {
  GeometryLocation _location;
  String _locationType;
  Viewport _viewport;
  Viewport _bounds;

  Geometry(
      {GeometryLocation location,
        String locationType,
        Viewport viewport,
        Viewport bounds}) {
    this._location = location;
    this._locationType = locationType;
    this._viewport = viewport;
    this._bounds = bounds;
  }

  GeometryLocation get location => _location;
  set location(GeometryLocation location) => _location = location;
  String get locationType => _locationType;
  set locationType(String locationType) => _locationType = locationType;
  Viewport get viewport => _viewport;
  set viewport(Viewport viewport) => _viewport = viewport;
  Viewport get bounds => _bounds;
  set bounds(Viewport bounds) => _bounds = bounds;

  Geometry.fromJson(Map<String, dynamic> json) {
    _location = json['location'] != null
        ? new GeometryLocation.fromJson(json['location'])
        : null;
    _locationType = json['location_type'];
    _viewport = json['viewport'] != null
        ? new Viewport.fromJson(json['viewport'])
        : null;
    _bounds =
    json['bounds'] != null ? new Viewport.fromJson(json['bounds']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._location != null) {
      data['location'] = this._location.toJson();
    }
    data['location_type'] = this._locationType;
    if (this._viewport != null) {
      data['viewport'] = this._viewport.toJson();
    }
    if (this._bounds != null) {
      data['bounds'] = this._bounds.toJson();
    }
    return data;
  }
}

class GeometryLocation {
  double _lat;
  double _lng;

  GeometryLocation({double lat, double lng}) {
    this._lat = lat;
    this._lng = lng;
  }

  double get lat => _lat;
  set lat(double lat) => _lat = lat;
  double get lng => _lng;
  set lng(double lng) => _lng = lng;

  GeometryLocation.fromJson(Map<String, dynamic> json) {
    _lat = json['lat'];
    _lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this._lat;
    data['lng'] = this._lng;
    return data;
  }
}

class Viewport {
  GeometryLocation _northeast;
  GeometryLocation _southwest;

  Viewport({GeometryLocation northeast, GeometryLocation southwest}) {
    this._northeast = northeast;
    this._southwest = southwest;
  }

  GeometryLocation get northeast => _northeast;
  set northeast(GeometryLocation northeast) => _northeast = northeast;
  GeometryLocation get southwest => _southwest;
  set southwest(GeometryLocation southwest) => _southwest = southwest;

  Viewport.fromJson(Map<String, dynamic> json) {
    _northeast = json['northeast'] != null
        ? new GeometryLocation.fromJson(json['northeast'])
        : null;
    _southwest = json['southwest'] != null
        ? new GeometryLocation.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._northeast != null) {
      data['northeast'] = this._northeast.toJson();
    }
    if (this._southwest != null) {
      data['southwest'] = this._southwest.toJson();
    }
    return data;
  }
}