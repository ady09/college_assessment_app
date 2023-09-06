import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_assessment_app/src/features/authentication/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

const String splash1 = "My";
const String splash2 = "Assessments";
const String tLogin = "Sign In";
const String tSignup = "Register";
const String loginText = "Please Enter Your Details!";
const String email = "Email";
const String password = "Password";
const String login = "Login";
const String forgot = "Forgot Password";
const String registerHeader = "Please Enter Your Details";
const String confirmPassword = "Confirm Password";
const String fullName = "Full Name";
const String done = "Done";
const String myAssessments = "My Assessments";

User? user = firebaseAuth.currentUser; 


var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;
var authController = AuthController.instance;
String? userIdConst = user?.uid;
