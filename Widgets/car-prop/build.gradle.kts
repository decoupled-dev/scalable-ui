plugins {
    alias(libs.plugins.android.library)
}

android {
    namespace = "com.scalableui.widgets.carprop"
    compileSdk {
        version = release(37)
    }
    defaultConfig {
        minSdk = 34
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
}

dependencies {
    compileOnly(files("${rootProject.projectDir}/libs/android.car.jar"))
}
