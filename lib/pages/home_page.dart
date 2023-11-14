// Flutter: Existing Libraries
import 'package:flutter/material.dart';

// Flutter: External Libraries
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

// Helpers
import '../helpers/container_clipper_helper.dart';

// HomePage: StatefulWidget Class
class HomePage extends StatefulWidget {
  // Static: Class Properties
  static const String routeName = "/home";

  // Constructor
  const HomePage({super.key});

  // CreateState: Override Class Method
  @override
  State<HomePage> createState() => _HomePageState();
}

// _HomePageState: Private State Class
class _HomePageState extends State<HomePage> {
  // Final: Class Properties
  final List<Color> _colorList = [
    Colors.blueAccent,
    Colors.lightBlue,
    Colors.lightBlue.shade500,
    Colors.lightBlue.shade400,
    Colors.lightBlue.shade300,
    Colors.lightBlue.shade200,
    Colors.lightBlue.shade100,
  ];
  final String _backgroundImageAssetLink = "assets/images/background.webp";
  final String _hotelSearchTitleText = "Hotels Search";
  final String _findHotelsButtonText = "find hotels";
  /* Form & Its Properties */
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _selectCityController = TextEditingController();
  final String _selectCityHintText = "Select city";
  final _switchController = ValueNotifier<bool>(false);

  // Override Lifecycle Methods
  @override
  void initState() {
    super.initState();
    _switchController.addListener(() {
      setState(() {
        if (_switchController.value) {
          _isPetsFriendly = true;
        } else {
          _isPetsFriendly = false;
        }
        print("_isPetsFriendly: $_isPetsFriendly");
      });
    });
  }

  // Changable: Class Properties
  bool _isClearDate = false;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day + 1,
  );
  String _nationalityText = "Select Nationality";
  String _planningText = "0 Room, 0 Adult, 0 Children";
  int _roomCount = 0;
  int _adultCount = 0;
  int _childCount = 0;
  bool _isPetsFriendly = false;

  // Functions
  Future<void> _onFindHotels() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Finding Hotels'),
          content: Container(
            width: 300.0,
            height: 100.0,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: const Text("Found 123 hotels!"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Search Again'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Show Hotels'),
            ),
          ],
        );
      },
    );
  }

  void _onClearDate() {
    setState(() {
      _isClearDate = true;
    });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      setState(() {
        _isClearDate = false;
        _startDate = args.value.startDate;
        _endDate = (args.value.endDate != null) ? args.value.endDate : _endDate;
      });
    }
  }

  Future<void> _showDatePickerDialogAndGetResult() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a Date'),
          content: Container(
            width: 300.0,
            height: 300.0,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SfDateRangePicker(
              onSelectionChanged: _onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.range,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showAndChooseNationality() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          _nationalityText = country.displayName.split("(")[0];
        });
      },
    );
  }

  void _applyRoomsAndGuests() {
    setState(() {
      _planningText =
          "$_roomCount Room, $_adultCount Adult, $_childCount Children";
    });
    Navigator.of(context).pop();
  }

  void _showAndChoosePlanning() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setInnerState) {
            return FractionallySizedBox(
              heightFactor: 0.9,
              child: Container(
                height: MediaQuery.of(context).size.height - 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 75.0,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 50.0),
                          const Text(
                            "Rooms and Guests",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              width: 50.0,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.black12,
                        child: Column(
                          children: [
                            const SizedBox(height: 20.0),
                            Container(
                              width: double.infinity,
                              height: 50.0,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Rooms",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      _counterButtonWidget(
                                        Icon(
                                          Icons.remove,
                                          color: (_roomCount <= 0)
                                              ? Colors.lightBlue.shade100
                                              : Colors.lightBlue,
                                        ),
                                        (_roomCount <= 0)
                                            ? null
                                            : () {
                                                setInnerState(() {
                                                  _roomCount--;
                                                });
                                              },
                                      ),
                                      const SizedBox(width: 10.0),
                                      Text(
                                        "$_roomCount",
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      _counterButtonWidget(
                                        Icon(
                                          Icons.add,
                                          color: (_roomCount >= 20)
                                              ? Colors.lightBlue.shade100
                                              : Colors.lightBlue,
                                        ),
                                        (_roomCount >= 20)
                                            ? null
                                            : () {
                                                setInnerState(() {
                                                  _roomCount++;
                                                });
                                              },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              width: double.infinity,
                              height: 250.0,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 10.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Rooms",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Adults",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          _counterButtonWidget(
                                            Icon(
                                              Icons.remove,
                                              color: (_adultCount <= 0)
                                                  ? Colors.lightBlue.shade100
                                                  : Colors.lightBlue,
                                            ),
                                            (_adultCount <= 0)
                                                ? null
                                                : () {
                                                    setInnerState(() {
                                                      _adultCount--;
                                                    });
                                                  },
                                          ),
                                          const SizedBox(width: 10.0),
                                          Text(
                                            "$_adultCount",
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(width: 10.0),
                                          _counterButtonWidget(
                                            Icon(
                                              Icons.add,
                                              color: (_adultCount >= 10)
                                                  ? Colors.lightBlue.shade100
                                                  : Colors.lightBlue,
                                            ),
                                            (_adultCount >= 10)
                                                ? null
                                                : () {
                                                    setInnerState(() {
                                                      _adultCount++;
                                                    });
                                                  },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Children",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          _counterButtonWidget(
                                            Icon(
                                              Icons.remove,
                                              color: (_childCount <= 0)
                                                  ? Colors.lightBlue.shade100
                                                  : Colors.lightBlue,
                                            ),
                                            (_childCount <= 0)
                                                ? null
                                                : () {
                                                    setInnerState(() {
                                                      _childCount--;
                                                    });
                                                  },
                                          ),
                                          const SizedBox(width: 10.0),
                                          Text(
                                            "$_childCount",
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(width: 10.0),
                                          _counterButtonWidget(
                                            Icon(
                                              Icons.add,
                                              color: (_childCount >= 10)
                                                  ? Colors.lightBlue.shade100
                                                  : Colors.lightBlue,
                                            ),
                                            (_childCount >= 10)
                                                ? null
                                                : () {
                                                    setInnerState(() {
                                                      _childCount++;
                                                    });
                                                  },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5.0,
                                      ),
                                      child: Scrollbar(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: List.generate(
                                              _childCount,
                                              (index) {
                                                return Container(
                                                  width: double.infinity,
                                                  height: 40.0,
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const SizedBox(
                                                            width: 20.0,
                                                          ),
                                                          Text(
                                                            "Age of child ${index + 1}",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Text(
                                                        "14 years",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              width: double.infinity,
                              height: 60.0,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 10.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Pets-friendly",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          SizedBox(width: 5.0),
                                          Icon(
                                            Icons.info_outline_rounded,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Only show stays that allow pets",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  AdvancedSwitch(
                                    controller: _switchController,
                                  ),
                                ],
                              ),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            InkWell(
                              onTap: _applyRoomsAndGuests,
                              child: Container(
                                width: double.infinity,
                                height: 50.0,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Text(
                                  "Apply",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Components
  Widget _counterButtonWidget(Icon icon, Function()? function) {
    return InkWell(
      onTap: function,
      child: Container(
        width: 40.0,
        height: 30.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(
            width: 1.5,
            color: (function == null)
                ? Colors.lightBlue.shade100
                : Colors.lightBlue,
          ),
        ),
        child: icon,
      ),
    );
  }

  // Widgets
  Widget _dateRangeWidget() {
    final String startDateString =
        "${_startDate.year}-${_startDate.month}-${_startDate.day}";
    final String endDateString =
        "${_endDate.year}-${_endDate.month}-${_endDate.day}";
    final String dateRangeString = "$startDateString ==> $endDateString";

    return Text(
      (_isClearDate) ? "Choose Date Range" : dateRangeString,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        color: Colors.lightBlue,
      ),
    );
  }

  // Build: Override Class Method
  @override
  Widget build(BuildContext context) {
    // Returning Widgets
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              _backgroundImageAssetLink,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
              clipper: ContainerClipper(),
              child: Container(
                width: 200.0,
                height: 60.0,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  color: Colors.lightBlue,
                  border: Border(
                    top: BorderSide(
                      width: 2,
                      color: Colors.lightBlue,
                    ),
                    right: BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: Text(
                  _hotelSearchTitleText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            SizedBox(
              width: double.infinity,
              height: 360.0,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 360.0,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: _onFindHotels,
                          child: SizedBox(
                            width: double.infinity,
                            height: 60.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _findHotelsButtonText,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 40.0,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 300,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _colorList,
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 50.0,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: TextFormField(
                              controller: _selectCityController,
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                label: Center(
                                  child: Text(
                                    _selectCityHintText,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 0.1,
                                    color: Colors.lightBlue,
                                  ),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 0.1,
                                    color: Colors.lightBlue,
                                  ),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          InkWell(
                            onTap: _showDatePickerDialogAndGetResult,
                            child: Container(
                              width: double.infinity,
                              height: 60.0,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(7.5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Colors.lightBlue),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(width: 15),
                                    _dateRangeWidget(),
                                    IconButton(
                                      onPressed: _onClearDate,
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            width: double.infinity,
                            height: 60.0,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(7.5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 30),
                                    Text(
                                      _nationalityText,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.lightBlue,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                  ],
                                ),
                                IconButton(
                                  onPressed: _showAndChooseNationality,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            width: double.infinity,
                            height: 60.0,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(7.5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Text(
                                      _planningText,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.lightBlue,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                  ],
                                ),
                                IconButton(
                                  onPressed: _showAndChoosePlanning,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
