plugins {
    alias(libs.plugins.android.application)
}

android {
    namespace = "com.scalableui.widgets.connections"
    compileSdk {
        version = release(37)
    }
    defaultConfig {
        applicationId = "com.scalableui.widgets.connections"
        minSdk = 34
        targetSdk = 36
        versionCode = 1
        versionName = "1.0"
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
}

dependencies {
    implementation(project(":car-prop"))
}
