import 'package:sportolingo/models/status_enum.dart';
import 'package:sportolingo/widgets/course_day_tile.dart';

List<CourseDayTile> taekwondoCourse = [
   CourseDayTile(
              day: 'Day 1',
              title: 'Side kick',
              status: Status.Now,
            ),
            CourseDayTile(
              day: 'Day 2',
              title: 'Front kick',
              status: Status.Blocked,
            ),
            CourseDayTile(
              day: 'Day 3',
              title: 'Basic blocks',
              status: Status.Blocked,
            ),
            CourseDayTile(
              day: 'Day 4',
              title: 'Exam basics',
              status: Status.Blocked,
            ),
];