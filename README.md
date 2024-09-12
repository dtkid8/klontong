# Klontong

A Flutter Project using MVVM architecture using Cubit (flutter_bloc), include unit test and Sentry(Error Monitoring). Also this project integrated with backend as service from Beeceptor(CRUD api mock). Secure the .env file with envied package.

## Sentry
![Screenshot 2024-09-12 174126](https://github.com/user-attachments/assets/dd8aa6a0-cc50-4509-9231-703b54775988)


## Features
- List Product
- Search Product (Match case by product name). If you search 'taro' it will only result the name 'Taro'.
- Add Product
- Detail Product

## Development

Clone the repository, then install the dependencies:

    flutter pub get

Create .env file in your root project folder:

    BASE_URL= https://caccae1d21fff909f461.free.beeceptor.com
    SENTRY_URL =https://7e5e9a53cbdc82b29e78968cbab71d76@o4507933971251200.ingest.de.sentry.io/4507933973151824
    
You can change the beeceptor url with your own beeceptor url, but you also must change the mock rules (For the endpoint "/api/product/"). 

Run the following to launch the code generation to generate .env file:

    dart run build_runner clean
    dart run build_runner build --delete-conflicting-outputs

Start the app:

    flutter run
