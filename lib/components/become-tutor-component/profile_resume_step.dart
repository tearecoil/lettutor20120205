import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor20120205/components/drop_down.dart';
import 'package:lettutor20120205/components/headline_text.dart';
import 'package:lettutor20120205/components/helper_text.dart';
import 'package:lettutor20120205/components/input_decoration.dart';
import 'package:lettutor20120205/components/text_input.dart';
import 'package:lettutor20120205/components/become-tutor-component/certificate_dialog.dart';
import 'package:lettutor20120205/components/become-tutor-component/specialties.dart';

class ProfileResumeStep extends StatefulWidget {
  const ProfileResumeStep({
    super.key,
    required this.formKey,
    required this.nameTextEditingController,
    required this.birthdayTextEditingController,
    required this.countryTextEditingController,
    required this.interestsTextEditingController,
    required this.educationTextEditingController,
    required this.experienceTextEditingController,
    required this.professionTextEditingController,
    required this.introductionTextEditingController,
    required this.certificateList,
    required this.languages,
    required this.teachingLevel,
    required this.teachingSpecialities,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameTextEditingController;
  final TextEditingController birthdayTextEditingController;
  final TextEditingController countryTextEditingController;
  final TextEditingController interestsTextEditingController;
  final TextEditingController educationTextEditingController;
  final TextEditingController experienceTextEditingController;
  final TextEditingController professionTextEditingController;
  final TextEditingController introductionTextEditingController;
  final List<Map<String, dynamic>> certificateList;
  final List<String> languages;
  final List<String?> teachingLevel;
  final List<String> teachingSpecialities;

  @override
  State<ProfileResumeStep> createState() => _ProfileResumeStepState();
}

class _ProfileResumeStepState extends State<ProfileResumeStep> {
  final studentOverallLevels = ['Beginner', 'Intermediate', 'Advanced'];
  void _onDateChanged(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse('1999-01-01'),
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      setState(() {
        widget.birthdayTextEditingController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _addCertificate(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) =>
          CerificateDialog(certificates: widget.certificateList),
    ).then((value) {
      if (value != null) {
        setState(() {
          widget.certificateList.add(value);
        });
      }
    });
  }

  void _removeCertificate(Map<String, dynamic> certificate) {
    setState(() {
      widget.certificateList.remove(certificate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Image.asset(
                  'assets/misc/profile_setup.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person_rounded, size: 62),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Set up your tutor profile',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 24),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Your tutor profile is your chance to market yourself to students on Tutoring. '
                      'You can make edits later on your profile settings page.',
                    ),
                    const SizedBox(height: 8),
                    const Text(
                        'New students may browse tutor profiles to find a tutor that fits their learning goals and personality. '
                        'Returning students may use the tutor profiles to find tutors they\'ve had great experiences with already.'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Form(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const HeadlineText(textHeadline: 'Basic Info'),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 140,
                    height: 140,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/avatar/user/user_avatar.jpeg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.person_rounded, size: 62),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const HelperText(
                  text: 'Please upload a professional photo. See guildlines.',
                ),
                const SizedBox(height: 12),
                const Text('Tutoring name'),
                TextInput(
                  controller: widget.nameTextEditingController,
                  validator: 'Please input your name!',
                ),
                const Text('I\'m from'),
                DropDownField(
                  controller: widget.countryTextEditingController,
                  list: countryList,
                  validator: 'Please input your country!',
                ),
                const Text('Date of Birth'),
                TextInput(
                  controller: widget.birthdayTextEditingController,
                  isReadOnly: true,
                  inputDecoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.calendar_month_outlined,
                      size: 20,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  onTap: () {
                    _onDateChanged(context);
                  },
                  validator: 'Please input your birthday!',
                ),
                const HeadlineText(textHeadline: 'CV'),
                const SizedBox(height: 12),
                const Text(
                  'Students will view this information on your profile to decide '
                  'if you\'re a good fit for them.',
                ),
                const SizedBox(height: 12),
                const HelperText(
                  text: 'In order to protect your privacy, '
                      'please do not share your personal information '
                      '(email, phone number, social email, skype, etc) in your profile.',
                ),
                const SizedBox(height: 12),
                const Text('Interests'),
                TextInput(
                  controller: widget.interestsTextEditingController,
                  isTextArea: true,
                  hintText:
                      'Interests, hobbies, memorable life experiences, or anything '
                      'else you\'d like to share!',
                  validator: 'Please input your interests!',
                ),
                const Text('Education'),
                TextInput(
                  controller: widget.educationTextEditingController,
                  isTextArea: true,
                  hintText:
                      'Example: "Bachelor of Arts in English from Cambly University; '
                      'Certified yoga instructor, Second Language Acquisition and Teaching '
                      '(SLAT) certificate from Cambly University"',
                  validator: 'Please input your interests!',
                ),
                const Text('Experience'),
                TextInput(
                  controller: widget.experienceTextEditingController,
                  isTextArea: true,
                  validator: 'Please input your experience!',
                ),
                const Text('Current or Previous Pression'),
                TextInput(
                  controller: widget.professionTextEditingController,
                  isTextArea: true,
                  validator: 'Please input your profession!',
                ),
                const Text('Certificate'),
                const SizedBox(height: 12),
                FormField(
                  builder: (FormFieldState state) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      OutlinedButton(
                        onPressed: () {
                          _addCertificate(context);
                          state.didChange(widget.certificateList);
                        },
                        child: const Text('Add new certificate'),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: ['Certificate Type', 'Certificate', 'Action']
                              .map(
                                (label) => DataColumn(
                                  label: Text(
                                    label,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          rows: widget.certificateList
                              .map<DataRow>(
                                (certificate) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Text(
                                          certificate['certificateType'] ?? ''),
                                    ),
                                    DataCell(
                                      Text(
                                        certificate['certificateFile']?.name ??
                                            '',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    DataCell(
                                      IconButton(
                                        onPressed: () {
                                          _removeCertificate(certificate);
                                          state.didChange(certificate);
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      if (state.hasError)
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            state.errorText!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                    ],
                  ),
                  validator: (value) {
                    if (widget.certificateList.isEmpty) {
                      return 'Please input at least one certificate!';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const HeadlineText(textHeadline: 'Languages I speak'),
                const SizedBox(height: 12),
                const Text('Languages'),
                const SizedBox(height: 8),
                FormField(
                  builder: (FormFieldState state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        DropdownButtonFormField2<String>(
                          isExpanded: true,
                          decoration: customInputDecoration.copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: -4,
                            ),
                          ),
                          items: List<DropdownMenuItem<String>>.generate(
                            worldLanguages.length,
                            (index) => DropdownMenuItem<String>(
                              enabled: false,
                              value: worldLanguages.keys.elementAt(index),
                              child: StatefulBuilder(
                                builder: (context, menuSetState) {
                                  final isSelected = widget.languages.contains(
                                      worldLanguages.keys.elementAt(index));
                                  return InkWell(
                                    onTap: () {
                                      isSelected
                                          ? widget.languages.remove(
                                              worldLanguages.keys
                                                  .elementAt(index))
                                          : widget.languages.add(worldLanguages
                                              .keys
                                              .elementAt(index));
                                      menuSetState(() {});
                                      state.didChange(widget.languages);
                                    },
                                    child: isSelected
                                        ? ListTile(
                                            title: Text(
                                              worldLanguages.values
                                                  .elementAt(index),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            tileColor: Colors.blue.shade100
                                                .withOpacity(0.4),
                                            trailing: Icon(
                                              Icons.check_rounded,
                                              color: Colors.blue.shade300,
                                            ),
                                          )
                                        : ListTile(
                                            title: Text(
                                              worldLanguages.values
                                                  .elementAt(index),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                  );
                                },
                              ),
                            ),
                          ),
                          hint: const Text('Select languages'),
                          onChanged: (value) {},
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.only(right: 8),
                          ),
                          iconStyleData: IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.grey.shade300,
                            ),
                            iconSize: 24,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 4,
                          runSpacing: 8,
                          children: List<Widget>.generate(
                            widget.languages.length,
                            (index) => Chip(
                              label: Text(
                                  worldLanguages[widget.languages[index]]!),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              side: BorderSide.none,
                              onDeleted: () {
                                widget.languages
                                    .remove(widget.languages[index]);
                                state.didChange(widget.languages);
                              },
                              deleteIcon: const Icon(
                                Icons.cancel_rounded,
                                size: 18,
                              ),
                              backgroundColor:
                                  Colors.grey.shade300.withOpacity(0.4),
                              deleteButtonTooltipMessage: '',
                            ),
                          ),
                        ),
                        if (state.hasError)
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              state.errorText!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                  validator: (value) {
                    if (widget.languages.isEmpty) {
                      return 'Please input at least one language!';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const HeadlineText(textHeadline: 'Who I teach'),
                const SizedBox(height: 12),
                const HelperText(
                  text: 'This is the first thing students '
                      'will see when looking for tutors.',
                ),
                const SizedBox(height: 12),
                const Text('Introduction'),
                TextInput(
                  controller: widget.introductionTextEditingController,
                  isTextArea: true,
                  hintText:
                      'Example: "I was a doctor for 35 years and can help you practice '
                      'business or medical English. I also enjoy teaching beginners '
                      'as I am very patient and always speak slowly and clearly."',
                  validator: 'Please input your introduction!',
                ),
                const Text('I am best at teaching students who are'),
                FormField(
                  builder: (FormFieldState state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: studentOverallLevels
                              .map<Widget>(
                                (level) => RadioListTile<String>(
                                  value: level,
                                  groupValue: widget.teachingLevel.first,
                                  onChanged: (value) {
                                    widget.teachingLevel[0] = value!;
                                    state.didChange(value);
                                  },
                                  title: Text(
                                    level,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  contentPadding: const EdgeInsets.all(0),
                                ),
                              )
                              .toList(),
                        ),
                        if (state.hasError)
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              state.errorText!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                  validator: (value) {
                    if (widget.teachingLevel.isEmpty) {
                      return 'Please input your teaching level!';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 12),
                const Text('My specialties are'),
                FormField(
                  builder: (FormFieldState state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: specialities
                              .map((e) => e.name!)
                              .map<Widget>(
                                (specialty) => CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value: widget.teachingSpecialities
                                      .contains(specialty),
                                  onChanged: (value) {
                                    if (widget.teachingSpecialities
                                        .contains(specialty)) {
                                      widget.teachingSpecialities
                                          .remove(specialty);
                                    } else {
                                      widget.teachingSpecialities
                                          .add(specialty);
                                    }
                                    state.didChange(value);
                                  },
                                  title: Text(
                                    specialty,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  contentPadding: const EdgeInsets.all(0),
                                ),
                              )
                              .toList(),
                        ),
                        if (state.hasError)
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              state.errorText!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                  validator: (value) {
                    if (widget.teachingSpecialities.isEmpty) {
                      return 'Please input your target specialties!';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const countryList = {
  "AF": "Afghanistan",
  "AL": "Albania",
  "DZ": "Algeria",
  "AS": "American Samoa",
  "AD": "Andorra",
  "AO": "Angola",
  "AI": "Anguilla",
  "AQ": "Antarctica",
  "AG": "Antigua and Barbuda",
  "AR": "Argentina",
  "AM": "Armenia",
  "AW": "Aruba",
  "AU": "Australia",
  "AT": "Austria",
  "AZ": "Azerbaijan",
  "BS": "Bahamas (the)",
  "BH": "Bahrain",
  "BD": "Bangladesh",
  "BB": "Barbados",
  "BY": "Belarus",
  "BE": "Belgium",
  "BZ": "Belize",
  "BJ": "Benin",
  "BM": "Bermuda",
  "BT": "Bhutan",
  "BO": "Bolivia (Plurinational State of)",
  "BQ": "Bonaire, Sint Eustatius and Saba",
  "BA": "Bosnia and Herzegovina",
  "BW": "Botswana",
  "BV": "Bouvet Island",
  "BR": "Brazil",
  "IO": "British Indian Ocean Territory (the)",
  "BN": "Brunei Darussalam",
  "BG": "Bulgaria",
  "BF": "Burkina Faso",
  "BI": "Burundi",
  "CV": "Cabo Verde",
  "KH": "Cambodia",
  "CM": "Cameroon",
  "CA": "Canada",
  "KY": "Cayman Islands (the)",
  "CF": "Central African Republic (the)",
  "TD": "Chad",
  "CL": "Chile",
  "CN": "China",
  "CX": "Christmas Island",
  "CC": "Cocos (Keeling) Islands (the)",
  "CO": "Colombia",
  "KM": "Comoros (the)",
  "CD": "Congo (the Democratic Republic of the)",
  "CG": "Congo (the)",
  "CK": "Cook Islands (the)",
  "CR": "Costa Rica",
  "HR": "Croatia",
  "CU": "Cuba",
  "CW": "Curaçao",
  "CY": "Cyprus",
  "CZ": "Czechia",
  "CI": "Côte d'Ivoire",
  "DK": "Denmark",
  "DJ": "Djibouti",
  "DM": "Dominica",
  "DO": "Dominican Republic (the)",
  "EC": "Ecuador",
  "EG": "Egypt",
  "SV": "El Salvador",
  "GQ": "Equatorial Guinea",
  "ER": "Eritrea",
  "EE": "Estonia",
  "SZ": "Eswatini",
  "ET": "Ethiopia",
  "FK": "Falkland Islands (the) [Malvinas]",
  "FO": "Faroe Islands (the)",
  "FJ": "Fiji",
  "FI": "Finland",
  "FR": "France",
  "GF": "French Guiana",
  "PF": "French Polynesia",
  "TF": "French Southern Territories (the)",
  "GA": "Gabon",
  "GM": "Gambia (the)",
  "GE": "Georgia",
  "DE": "Germany",
  "GH": "Ghana",
  "GI": "Gibraltar",
  "GR": "Greece",
  "GL": "Greenland",
  "GD": "Grenada",
  "GP": "Guadeloupe",
  "GU": "Guam",
  "GT": "Guatemala",
  "GG": "Guernsey",
  "GN": "Guinea",
  "GW": "Guinea-Bissau",
  "GY": "Guyana",
  "HT": "Haiti",
  "HM": "Heard Island and McDonald Islands",
  "VA": "Holy See (the)",
  "HN": "Honduras",
  "HK": "Hong Kong",
  "HU": "Hungary",
  "IS": "Iceland",
  "IN": "India",
  "ID": "Indonesia",
  "IR": "Iran (Islamic Republic of)",
  "IQ": "Iraq",
  "IE": "Ireland",
  "IM": "Isle of Man",
  "IL": "Israel",
  "IT": "Italy",
  "JM": "Jamaica",
  "JP": "Japan",
  "JE": "Jersey",
  "JO": "Jordan",
  "KZ": "Kazakhstan",
  "KE": "Kenya",
  "KI": "Kiribati",
  "KP": "Korea (the Democratic People's Republic of)",
  "KR": "Korea (the Republic of)",
  "KW": "Kuwait",
  "KG": "Kyrgyzstan",
  "LA": "Lao People's Democratic Republic (the)",
  "LV": "Latvia",
  "LB": "Lebanon",
  "LS": "Lesotho",
  "LR": "Liberia",
  "LY": "Libya",
  "LI": "Liechtenstein",
  "LT": "Lithuania",
  "LU": "Luxembourg",
  "MO": "Macao",
  "MG": "Madagascar",
  "MW": "Malawi",
  "MY": "Malaysia",
  "MV": "Maldives",
  "ML": "Mali",
  "MT": "Malta",
  "MH": "Marshall Islands (the)",
  "MQ": "Martinique",
  "MR": "Mauritania",
  "MU": "Mauritius",
  "YT": "Mayotte",
  "MX": "Mexico",
  "FM": "Micronesia (Federated States of)",
  "MD": "Moldova (the Republic of)",
  "MC": "Monaco",
  "MN": "Mongolia",
  "ME": "Montenegro",
  "MS": "Montserrat",
  "MA": "Morocco",
  "MZ": "Mozambique",
  "MM": "Myanmar",
  "NA": "Namibia",
  "NR": "Nauru",
  "NP": "Nepal",
  "NL": "Netherlands (the)",
  "NC": "New Caledonia",
  "NZ": "New Zealand",
  "NI": "Nicaragua",
  "NE": "Niger (the)",
  "NG": "Nigeria",
  "NU": "Niue",
  "NF": "Norfolk Island",
  "MP": "Northern Mariana Islands (the)",
  "NO": "Norway",
  "OM": "Oman",
  "PK": "Pakistan",
  "PW": "Palau",
  "PS": "Palestine, State of",
  "PA": "Panama",
  "PG": "Papua New Guinea",
  "PY": "Paraguay",
  "PE": "Peru",
  "PH": "Philippines (the)",
  "PN": "Pitcairn",
  "PL": "Poland",
  "PT": "Portugal",
  "PR": "Puerto Rico",
  "QA": "Qatar",
  "MK": "Republic of North Macedonia",
  "RO": "Romania",
  "RU": "Russian Federation",
  "RW": "Rwanda",
  "RE": "Réunion",
  "BL": "Saint Barthélemy",
  "SH": "Saint Helena, Ascension and Tristan da Cunha",
  "KN": "Saint Kitts and Nevis",
  "LC": "Saint Lucia",
  "MF": "Saint Martin (French part)",
  "PM": "Saint Pierre and Miquelon",
  "VC": "Saint Vincent and the Grenadines",
  "WS": "Samoa",
  "SM": "San Marino",
  "ST": "Sao Tome and Principe",
  "SA": "Saudi Arabia",
  "SN": "Senegal",
  "RS": "Serbia",
  "SC": "Seychelles",
  "SL": "Sierra Leone",
  "SG": "Singapore",
  "SX": "Sint Maarten (Dutch part)",
  "SK": "Slovakia",
  "SI": "Slovenia",
  "SB": "Solomon Islands",
  "SO": "Somalia",
  "ZA": "South Africa",
  "GS": "South Georgia and the South Sandwich Islands",
  "SS": "South Sudan",
  "ES": "Spain",
  "LK": "Sri Lanka",
  "SD": "Sudan (the)",
  "SR": "Suriname",
  "SJ": "Svalbard and Jan Mayen",
  "SE": "Sweden",
  "CH": "Switzerland",
  "SY": "Syrian Arab Republic",
  "TW": "Taiwan",
  "TJ": "Tajikistan",
  "TZ": "Tanzania, United Republic of",
  "TH": "Thailand",
  "TL": "Timor-Leste",
  "TG": "Togo",
  "TK": "Tokelau",
  "TO": "Tonga",
  "TT": "Trinidad and Tobago",
  "TN": "Tunisia",
  "TR": "Turkey",
  "TM": "Turkmenistan",
  "TC": "Turks and Caicos Islands (the)",
  "TV": "Tuvalu",
  "UG": "Uganda",
  "UA": "Ukraine",
  "AE": "United Arab Emirates (the)",
  "GB": "United Kingdom of Great Britain and Northern Ireland (the)",
  "UM": "United States Minor Outlying Islands (the)",
  "US": "United States of America (the)",
  "UY": "Uruguay",
  "UZ": "Uzbekistan",
  "VU": "Vanuatu",
  "VE": "Venezuela (Bolivarian Republic of)",
  "VN": "Viet Nam",
  "VG": "Virgin Islands (British)",
  "VI": "Virgin Islands (U.S.)",
  "WF": "Wallis and Futuna",
  "EH": "Western Sahara",
  "YE": "Yemen",
  "ZM": "Zambia",
  "ZW": "Zimbabwe",
  "AX": "Åland Islands"
};

const worldLanguages = {
  "aa": "Afar",
  "ab": "Abkhazian",
  "ae": "Avestan",
  "af": "Afrikaans",
  "ak": "Akan",
  "am": "Amharic",
  "an": "Aragonese",
  "ar": "Arabic",
  "as": "Assamese",
  "av": "Avaric",
  "ay": "Aymara",
  "az": "Azerbaijani",
  "ba": "Bashkir",
  "be": "Belarusian",
  "bg": "Bulgarian",
  "bh": "Bihari languages",
  "bi": "Bislama",
  "bm": "Bambara",
  "bn": "Bengali",
  "bo": "Tibetan",
  "br": "Breton",
  "bs": "Bosnian",
  "ca": "Catalan",
  "ce": "Chechen",
  "ch": "Chamorro",
  "co": "Corsican",
  "cr": "Cree",
  "cs": "Czech",
  "cu": "Church Slavic",
  "cv": "Chuvash",
  "cy": "Welsh",
  "da": "Danish",
  "de": "German",
  "dv": "Maldivian",
  "dz": "Dzongkha",
  "ee": "Ewe",
  "el": "Greek",
  "en": "English",
  "eo": "Esperanto",
  "es": "Spanish",
  "et": "Estonian",
  "eu": "Basque",
  "fa": "Persian",
  "ff": "Fulah",
  "fi": "Finnish",
  "fj": "Fijian",
  "fo": "Faroese",
  "fr": "French",
  "fy": "Western Frisian",
  "ga": "Irish",
  "gd": "Gaelic",
  "gl": "Galician",
  "gn": "Guarani",
  "gu": "Gujarati",
  "gv": "Manx",
  "ha": "Hausa",
  "he": "Hebrew",
  "hi": "Hindi",
  "ho": "Hiri Motu",
  "hr": "Croatian",
  "ht": "Haitian",
  "hu": "Hungarian",
  "hy": "Armenian",
  "hz": "Herero",
  "ia": "Interlingua",
  "id": "Indonesian",
  "ie": "Interlingue",
  "ig": "Igbo",
  "ii": "Sichuan Yi",
  "ik": "Inupiaq",
  "io": "Ido",
  "is": "Icelandic",
  "it": "Italian",
  "iu": "Inuktitut",
  "ja": "Japanese",
  "jv": "Javanese",
  "ka": "Georgian",
  "kg": "Kongo",
  "ki": "Kikuyu",
  "kj": "Kuanyama",
  "kk": "Kazakh",
  "kl": "Kalaallisut",
  "km": "Central Khmer",
  "kn": "Kannada",
  "ko": "Korean",
  "kr": "Kanuri",
  "ks": "Kashmiri",
  "ku": "Kurdish",
  "kv": "Komi",
  "kw": "Cornish",
  "ky": "Kirghiz",
  "la": "Latin",
  "lb": "Luxembourgish",
  "lg": "Ganda",
  "li": "Limburgan",
  "ln": "Lingala",
  "lo": "Lao",
  "lt": "Lithuanian",
  "lu": "Luba-Katanga",
  "lv": "Latvian",
  "mg": "Malagasy",
  "mh": "Marshallese",
  "mi": "Maori",
  "mk": "Macedonian",
  "ml": "Malayalam",
  "mn": "Mongolian",
  "mr": "Marathi",
  "ms": "Malay",
  "mt": "Maltese",
  "my": "Burmese",
  "na": "Nauru",
  "nb": "Norwegian",
  "nd": "North Ndebele",
  "ne": "Nepali",
  "ng": "Ndonga",
  "nl": "Dutch",
  "nn": "Norwegian",
  "no": "Norwegian",
  "nr": "South Ndebele",
  "nv": "Navajo",
  "ny": "Chichewa",
  "oc": "Occitan",
  "oj": "Ojibwa",
  "om": "Oromo",
  "or": "Oriya",
  "os": "Ossetic",
  "pa": "Panjabi",
  "pi": "Pali",
  "pl": "Polish",
  "ps": "Pushto",
  "pt": "Portuguese",
  "qu": "Quechua",
  "rm": "Romansh",
  "rn": "Rundi",
  "ro": "Romanian",
  "ru": "Russian",
  "rw": "Kinyarwanda",
  "sa": "Sanskrit",
  "sc": "Sardinian",
  "sd": "Sindhi",
  "se": "Northern Sami",
  "sg": "Sango",
  "si": "Sinhala",
  "sk": "Slovak",
  "sl": "Slovenian",
  "sm": "Samoan",
  "sn": "Shona",
  "so": "Somali",
  "sq": "Albanian",
  "sr": "Serbian",
  "ss": "Swati",
  "st": "Sotho, Southern",
  "su": "Sundanese",
  "sv": "Swedish",
  "sw": "Swahili",
  "ta": "Tamil",
  "te": "Telugu",
  "tg": "Tajik",
  "th": "Thai",
  "ti": "Tigrinya",
  "tk": "Turkmen",
  "tl": "Tagalog",
  "tn": "Tswana",
  "to": "Tonga",
  "tr": "Turkish",
  "ts": "Tsonga",
  "tt": "Tatar",
  "tw": "Twi",
  "ty": "Tahitian",
  "ug": "Uighur",
  "uk": "Ukrainian",
  "ur": "Urdu",
  "uz": "Uzbek",
  "ve": "Venda",
  "vi": "Vietnamese",
  "vo": "Volapük",
  "wa": "Walloon",
  "wo": "Wolof",
  "xh": "Xhosa",
  "yi": "Yiddish",
  "yo": "Yoruba",
  "za": "Zhuang",
  "zh": "Chinese",
  "zu": "Zulu"
};
