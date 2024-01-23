import 'package:lettutor20120205/models/course-topic/learn_topic.dart';
import 'package:lettutor20120205/models/course-topic/test_preparation.dart';

final specialities = [
  ...subjects,
  ...testPreparations,
];
final subjects = [
  LearnTopic(
    id: 3,
    key: 'english-for-kids',
    name: 'English for kids',
  ),
  LearnTopic(
    id: 4,
    key: 'business-english',
    name: 'Business English',
  ),
  LearnTopic(
    id: 5,
    key: 'conversational-english',
    name: 'Conversational English',
  ),
];
final testPreparations = [
  TestPreparation(
    id: 1,
    key: 'starters',
    name: 'STARTERS',
  ),
  TestPreparation(
    id: 2,
    key: 'movers',
    name: 'MOVERS',
  ),
  TestPreparation(
    id: 3,
    key: 'flyers',
    name: 'FLYERS',
  ),
  TestPreparation(
    id: 4,
    key: 'ket',
    name: 'KET',
  ),
  TestPreparation(
    id: 5,
    key: 'pet',
    name: 'PET',
  ),
  TestPreparation(
    id: 6,
    key: 'ielts',
    name: 'IELTS',
  ),
  TestPreparation(
    id: 7,
    key: 'toefl',
    name: 'TOEFL',
  ),
  TestPreparation(
    id: 8,
    key: 'toeic',
    name: 'TOEIC',
  ),
];
