import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/src/authexceptionmodels/authexceptions.dart';
import 'package:firebase_authentication/src/models/model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'utils/firebaseuser.dart';

class AuthenticationRepository {
  late FirebaseAuth _firebaseAuth ;
  late GoogleSignIn _googleSignIn;

 AuthenticationRepository({FirebaseAuth? firebaseAuth,GoogleSignIn? googleSignIn}){
    this._firebaseAuth=firebaseAuth??FirebaseAuth.instance;
    this._googleSignIn=googleSignIn??GoogleSignIn.standard();
  }

  Stream<UserModel> getuser() {
 return _firebaseAuth.authStateChanges().map((firebaseuser) {
   if(firebaseuser==null)return UserModel();
   return firebaseuser.toUser();
 });
  }

  loginwithgoogle()async{
   try {
     GoogleSignInAccount? _googlesiginaccount=await _googleSignIn.signIn();
     if(_googlesiginaccount==null)return;
     GoogleSignInAuthentication _googleSignInAuthentication=await _googlesiginaccount.authentication;
     OAuthCredential _credential=GoogleAuthProvider.credential(idToken:_googleSignInAuthentication.idToken,accessToken: _googleSignInAuthentication.accessToken );
     _firebaseAuth.signInWithCredential(_credential);
   } on FirebaseAuthException catch(err){
     throw LoginWithGoogleException.fromCode(err.code);
   }
   catch(err){
     throw LoginWithEmailAndPasswordException("Login with Google Failed");
   }
  }

  signinwithemailandpassword(String email,String password)async{
    try {
     await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw LoginWithEmailAndPasswordException.fromCode(e.code);
      // TODO
    }
    catch(err){
      throw LoginWithEmailAndPasswordException("Sign in Failed");
    }

  }

  registeruserwithemail(String email,String password)async{
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw CreatUserWithEmailAndPasswordException.fromCode(e.code);
      // TODO
    }
    catch(err){
      throw CreatUserWithEmailAndPasswordException("Registration Failed");
    }
 
  }

  logoutuser(){
    _firebaseAuth.signOut();
    _googleSignIn.signOut();
  }
  
}
