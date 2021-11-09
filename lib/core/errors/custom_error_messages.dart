const String USER_NOT_FOUND = 'user-not-found';
const String WRONG_PASSWORD = 'wrong-password';

class CustomErrorMessages {
  static Map<String, String> errorMessages = {
    USER_NOT_FOUND: 'This user does not exist',
    WRONG_PASSWORD: 'Wrong email or password',
  };
}
