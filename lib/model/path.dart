
class AppRoutePath {
  final bool isLoggedIn;
  final String? authAction;
  final String? libraryUid;
  final bool isUnknown;


  AppRoutePath.home(this.isLoggedIn)
    : libraryUid = null,
      isUnknown = false,
      authAction = null;
  
  AppRoutePath.auth(this.authAction)
    : isLoggedIn = false,
      isUnknown = false,
      libraryUid = null;

  AppRoutePath.library(this.libraryUid)
    : isUnknown = false,
      isLoggedIn = true,
      authAction = null;
  
  AppRoutePath.unknown()
    : isLoggedIn = false,
      libraryUid = null,
      authAction = null,
      isUnknown = true;
  
  bool get isUnknownPage => isUnknown;

  bool get isHomePage => !isUnknown && authAction == null && libraryUid == null;

  bool get isLoggedOutStack => !isUnknown && !isLoggedIn;

  bool get isLoggedOutPage => !isUnknown && !isLoggedIn && authAction == null;

  bool get isLibrariesPage => !isUnknown && isLoggedIn && libraryUid == null;

  bool get isLoginPage => authAction == 'login';

  bool get isRegisterPage => authAction == 'register';

  bool get isLibraryPage => libraryUid != null;
}