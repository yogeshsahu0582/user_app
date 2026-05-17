plugins {

    id("com.android.application")

    id("org.jetbrains.kotlin.android")

    id("dev.flutter.flutter-gradle-plugin")
}

android {

    ndkVersion = "27.0.12077973"

    namespace = "com.pa.userapp"

    compileSdk = 35

    defaultConfig {

        applicationId = "com.pa.userapp"

        minSdk = flutter.minSdkVersion

        targetSdk = 35

        versionCode = 1

        versionName = "1.0"
    }

    compileOptions {

        sourceCompatibility =
            JavaVersion.VERSION_21

        targetCompatibility =
            JavaVersion.VERSION_21
    }

    kotlinOptions {

        jvmTarget = "21"
    }

    buildTypes {

        release {

            signingConfig =
                signingConfigs.getByName("debug")
        }
    }
}

flutter {

    source = "../.."
}
