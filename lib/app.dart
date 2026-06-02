import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'presentation/page/etc/splash_screen/splash_screen.dart';
import 'presentation/page/etc/login&sign_up/login.dart';
import 'presentation/page/etc/login&sign_up/sign_up.dart';
import 'presentation/page/etc/login&sign_up/forgot_password.dart';
import 'presentation/page/screen_design_1/home_screen/home_screen.dart';
import 'presentation/page/etc/work_map/work_map.dart';
import 'presentation/page/etc/menu/menu.dart';
import 'presentation/page/etc/notify/notify.dart';
import 'presentation/page/screen_design_1/work_information/work_information.dart';
import 'presentation/page/apply_work/apply/apply.dart';
import 'presentation/page/apply_work/work_information_apply/work_information_apply.dart';
import 'presentation/page/apply_work/apply_success_fail/apply_success/apply_success.dart';
import 'presentation/page/apply_work/apply_success_fail/apply_fail/apply_fail.dart';
import 'presentation/page/screen_design_1/applicant_check/applicant_check.dart';
import 'presentation/page/screen_design_1/applicant_profile/applicant_profile.dart';
import 'presentation/page/apply_work/apply_list/apply_list.dart';
import 'presentation/page/apply_work/applying_work/applying_work.dart';
import 'presentation/page/recruit_and_announcement/work_recruit/work_recruit.dart';
import 'presentation/page/party_recruit_and_disband_announce/party_recruit/recruit_success.dart';
import 'presentation/page/party_recruit_and_disband_announce/party_recruit/recruit_fail.dart';
import 'presentation/page/recruit_and_announcement/recruit_list/recruit_list.dart';
import 'presentation/page/recruit_and_announcement/recruit_announcement/recruit_announcement.dart';
import 'presentation/page/recruit_and_announcement/announcement_edit/announcement_edit.dart';
import 'presentation/page/party_recruit_and_disband_announce/party_disband/disband_double_check.dart';
import 'presentation/page/party_recruit_and_disband_announce/party_disband/disband_success.dart';
import 'presentation/page/party_recruit_and_disband_announce/party_disband/disband_fail.dart';
import 'presentation/page/etc/participating_party/participating_party.dart';
import 'presentation/page/etc/party_member_profile/party_member_profile.dart';
import 'presentation/page/etc/party_exit/party_exit_double_check.dart';
import 'presentation/page/etc/party_exit/party_exit_success.dart';
import 'presentation/page/etc/party_exit/party_exit_fail.dart';
import 'presentation/page/etc/profile_and_detail_edit/profile_and_detail_edit.dart';
import 'presentation/page/etc/find_work/find_work.dart';
import 'presentation/page/etc/find_work_filter/find_work_filter.dart';
import 'presentation/page/etc/find_party/find_party.dart';
import 'presentation/page/etc/find_party_filter/find_party_filter.dart';
import 'presentation/page/etc/personal_info/personal_info.dart';
import 'presentation/page/recruit_and_announcement/recruit_manage_select/recruit_manage_select.dart';
import 'presentation/page/etc/waiting/waiting.dart';

import 'data/models/notify_data_structure.dart';
import 'data/models/find_data_structures.dart';
import 'data/models/applicant_check_data_structure.dart';
import 'data/models/apply_data_structures.dart';
import 'data/models/recruit_data_structures.dart';

class PageRoutes {
  PageRoutes._();

  static const splash = '/';
  static const login = '/login';
  static const signUp = '/sign_up';
  static const forgotPassword = '/forgot_password';

  static const home = '/home';
  static const map = '/map';
  static const menu = '/menu';

  static const notify = '/notify';
  static const workInformation = '/work_information';
  static const applyWork = '/apply_work';
  static const applySuccess = '/apply_success';
  static const applyFail = '/apply_fail';
  static const applicantCheck = '/applicant_check';
  static const applicantProfile = '/applicant_profile';

  static const apply = '/apply';
  static const applyList = '/apply_list';
  static const applyingWork = '/applying_work';

  static const workRecruit = '/work_recruit';
  static const recruitSuccess = '/recruit_success';
  static const recruitFail = '/recruit_fail';
  static const recruitList = '/recruit_list';
  static const recruitAnnouncement = '/recruit_announcement';
  static const announcementEdit = '/announcement_edit';
  static const disbandDoubleCheck = '/disband_double_check';
  static const disbandSuccess = '/disband_success';
  static const disbandFail = '/disband_fail';

  static const participatingParty = '/participating_party';
  static const partyMemberProfile = '/party_member_profile';
  static const partyExitDoubleCheck = '/party_exit_double_check';
  static const partyExitSuccess = '/party_exit_success';
  static const partyExitFail = '/party_exit_fail';

  static const profileEdit = '/profile_edit';

  static const findWork = '/find_work';
  static const findWorkFilter = '/find_work_filter';
  static const findParty = '/find_party';
  static const findPartyFilter = '/find_party_filter';
  static const personalInfo = '/personal_info';
  static const recruitManageSelect = '/recruit_manage_select';
  static const waiting = '/waiting';
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Party Maker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.notoSansKr().fontFamily,
        textTheme: GoogleFonts.notoSansKrTextTheme(),
      ),
      initialRoute: PageRoutes.splash,
      onGenerateRoute: generateRoute,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings routes) {
    final args = routes.arguments as Map<String, dynamic>?;

    Widget destinationPage;
    switch (routes.name) {
      case PageRoutes.splash:
        destinationPage = const SplashScreen();
      case PageRoutes.login:
        destinationPage = const Login();
      case PageRoutes.signUp:
        destinationPage = const SignUp();
      case PageRoutes.forgotPassword:
        destinationPage = const ForgotPassword();

      case PageRoutes.home:
        destinationPage = HomeScreen(
          logo: args?['logo'] as String?,
          profileContent: getArg(
            args,
            'profileContent',
            List.generate(4, (_) => ''),
          ),
        );
      case PageRoutes.map:
        destinationPage = const WorkMap();
      case PageRoutes.menu:
        destinationPage = Menu(
          name: getArg(args, 'name', ''),
          profileImage: args?['profileImage'] as String?,
        );

      case PageRoutes.notify:
        destinationPage = Notify(
          notification: getArg(args, 'notification', <NotificationItem>[]),
          position: getArg(args, 'position', <String>[]),
          profileImage: args?['profileImage'] as String?,
        );
      case PageRoutes.workInformation:
        destinationPage = WorkInformation(
          workName: getArg(args, 'workName', ''),
          workOverview: getArg(args, 'workOverview', ''),
          workDetail: getArg(args, 'workDetail', ''),
          leaderProfile: getArg(args, 'leaderProfile', <String>[]),
          position: getArg(args, 'position', <String>[]),
          poster: args?['poster'] as String?,
          positionOccupy: args?['positionOccupy'] as List<bool>?,
        );
      case PageRoutes.applyWork:
        destinationPage = WorkInformationApply(
          workName: getArg(args, 'workName', ''),
          workOverview: getArg(args, 'workOverview', ''),
          workDetail: getArg(args, 'workDetail', ''),
          leaderProfile: getArg(args, 'leaderProfile', <String>[]),
          position: getArg(args, 'position', <String>[]),
          poster: args?['poster'] as String?,
          positionOccupy: args?['positionOccupy'] as List<bool>?,
        );
      case PageRoutes.applySuccess:
        destinationPage = const ApplySuccess();
      case PageRoutes.applyFail:
        destinationPage = const ApplyFail();
      case PageRoutes.applicantCheck:
        destinationPage = ApplicantCheck(
          position: getArg(args, 'position', <String>[]),
          applicants: args?['applicants'] as List<ApplicantItem>?,
        );
      case PageRoutes.applicantProfile:
        destinationPage = ApplicantProfile(
          name: getArg(args, 'name', ''),
          introduction: getArg(args, 'introduction', ''),
          spec: getArg(args, 'spec', ''),
          applicationId: getArg(args, 'applicationId', 0),
        );

      case PageRoutes.apply:
        destinationPage = Apply(
          workName: getArg(args, 'workName', ''),
          profile: args?['profile'] as List<String>?,
          poster: args?['poster'] as String?,
        );
      case PageRoutes.applyList:
        destinationPage = ApplyList(apply: args?['apply'] as List<ApplyItem>?);
      case PageRoutes.applyingWork:
        destinationPage = ApplyingWork(
          workName: getArg(args, 'workName', ''),
          profile: getArg(args, 'profile', <String>[]),
          poster: args?['poster'] as String?,
        );

      case PageRoutes.workRecruit:
        destinationPage = WorkRecruit(
          profile: args?['profile'] as List<String>?,
        );
      case PageRoutes.recruitSuccess:
        destinationPage = const RecruitSuccess();
      case PageRoutes.recruitFail:
        destinationPage = const RecruitFail();
      case PageRoutes.recruitList:
        destinationPage = RecruitList(
          apply: args?['apply'] as List<RecruitItem>?,
        );
      case PageRoutes.recruitAnnouncement:
        destinationPage = RecruitAnnouncement(
          workName: getArg(args, 'workName', ''),
          partyNameIntroduction: getArg(args, 'partyNameIntroduction', ''),
          position: getArg(args, 'position', <String>[]),
          preferences: args?['preferences'] as List<String>?,
          partyId: getArg(args, 'partyId', 0),
        );
      case PageRoutes.announcementEdit:
        destinationPage = AnnouncementEdit(
          workName: getArg(args, 'workName', ''),
          partyNameIntroduction: getArg(args, 'partyNameIntroduction', ''),
          positions: getArg(args, 'positions', <String>[]),
          preferences: args?['preferences'] as List<String>?,
        );
      case PageRoutes.disbandDoubleCheck:
        destinationPage = DisbandDoubleCheck(
          partyId: getArg(args, 'partyId', 0),
        );
      case PageRoutes.disbandSuccess:
        destinationPage = const DisbandSuccess();
      case PageRoutes.disbandFail:
        destinationPage = const DisbandFail();

      case PageRoutes.participatingParty:
        destinationPage = ParticipatingParty(
          workName: getArg(args, 'workName', ''),
          workOverview: getArg(args, 'workOverview', ''),
          workDetail: getArg(args, 'workDetail', ''),
          leaderProfile: getArg(args, 'leaderProfile', <String>[]),
          position: getArg(args, 'position', <String>[]),
          poster: args?['poster'] as String?,
          positionOccupy: args?['positionOccupy'] as List<bool>?,
        );
      case PageRoutes.partyMemberProfile:
        destinationPage = PartyMemberProfile(
          profileContent: getArg(
            args,
            'profileContent',
            List.generate(2, (_) => ''),
          ),
          introduction: getArg(args, 'introduction', ''),
          spec: getArg(args, 'spec', ''),
          favorites: getArg(args, 'preferences', List.generate(3, (_) => '')),
          positions: getArg(args, 'positions', <String>[]),
          profileImage: args?['profileImage'] as String?,
        );
      case PageRoutes.partyExitDoubleCheck:
        destinationPage = const PartyExitDoubleCheck();
      case PageRoutes.partyExitSuccess:
        destinationPage = const PartyExitSuccess();
      case PageRoutes.partyExitFail:
        destinationPage = const PartyExitFail();

      case PageRoutes.profileEdit:
        destinationPage = ProfileAndDetailEdit(
          profileContent: getArg(
            args,
            'profileContent',
            List.generate(4, (_) => ''),
          ),
          introduction: getArg(args, 'introduction', ''),
          spec: getArg(args, 'spec', ''),
          favorites: getArg(args, 'favorites', List.generate(3, (_) => '')),
        );

      case PageRoutes.findWork:
        destinationPage = FindWork(
          workList: getArg(args, 'workList', <WorkItem>[]),
        );
      case PageRoutes.findWorkFilter:
        destinationPage = FindWorkFilter(
          filterData: getArg(args, 'filterData', <FilterItem>[]),
          detailCategory: getArg(
            args,
            'detailCategory',
            <String, List<String>>{},
          ),
        );
      case PageRoutes.findParty:
        destinationPage = FindParty(
          partyList: getArg(args, 'partyList', <PartyItem>[]),
        );
      case PageRoutes.findPartyFilter:
        destinationPage = FindPartyFilter(
          filterData: getArg(args, 'filterData', <FilterItem>[]),
          detailCategory: getArg(
            args,
            'detailCategory',
            <String, List<String>>{},
          ),
        );

      case PageRoutes.personalInfo:
        destinationPage = PersonalInfo(loginId: getArg(args, 'loginId', ''));

      case PageRoutes.recruitManageSelect:
        destinationPage = RecruitManageSelect(
          recruitList: args?['recruitList'] as List<RecruitItem>?,
        );
      case PageRoutes.waiting:
        destinationPage = const Waiting();

      default:
        destinationPage = Scaffold(
          body: Center(child: Text('unknown route: ${routes.name}')),
        );
    }

    return MaterialPageRoute(builder: (_) => destinationPage);
  }

  static T getArg<T>(Map<String, dynamic>? args, String key, T fallback) =>
      (args?[key] as T?) ?? fallback;
}
