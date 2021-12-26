
class AppRoutePath {
  final bool isLoggedIn;
  final String? authAction;
  final String? libraryUid;
  final String? entryUid;
  final bool isUnknown;


  AppRoutePath.home(this.isLoggedIn)
    : libraryUid = null,
      isUnknown = false,
      entryUid = null,
      authAction = null;
      
  
  AppRoutePath.auth(this.authAction)
    : isLoggedIn = false,
      isUnknown = false,
      entryUid = null,
      libraryUid = null;

  AppRoutePath.library(this.libraryUid)
    : isUnknown = false,
      isLoggedIn = true,
      entryUid = null,
      authAction = null;
  
  AppRoutePath.entry(this.libraryUid, this.entryUid)
    : isUnknown = false,
      isLoggedIn = true,
      authAction = null;
  
  AppRoutePath.unknown()
    : isLoggedIn = false,
      libraryUid = null,
      authAction = null,
      entryUid = null,
      isUnknown = true;
  
  bool get isUnknownPage => isUnknown;

  bool get isHomePage => !isUnknown && authAction == null && libraryUid == null;

  bool get isLoggedOutStack => !isUnknown && !isLoggedIn;

  bool get isLoggedOutPage => !isUnknown && !isLoggedIn && authAction == null;

  bool get isLibrariesPage => !isUnknown && isLoggedIn && libraryUid == null;

  bool get isLoginPage => authAction == 'login';

  bool get isRegisterPage => authAction == 'register';

  bool get isLibraryPage => libraryUid != null && entryUid == null;

  bool get isDetailsPage => entryUid != null;
}