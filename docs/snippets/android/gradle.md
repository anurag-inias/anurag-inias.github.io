# Gradle configuration

## Overall

=== "build.gradle.kts"

    ```kotlin
    // Top-level build file where you can add configuration options common to all sub-projects/modules.
    plugins {
      alias(libs.plugins.android.application) apply false
      alias(libs.plugins.org.jetbrains.kotlin.android) apply false
      alias(libs.plugins.compose.compiler) apply false
      alias(libs.plugins.protobuf) apply false
      // Need to be exact same version as Kotlin
      // https://mvnrepository.com/artifact/com.google.devtools.ksp/com.google.devtools.ksp.gradle.plugin
      id("com.google.devtools.ksp") version "2.1.20-2.0.0"
    }
    ```

=== "app/build.gradle.kts"

    ```kotlin
    import com.google.protobuf.gradle.id
    import org.gradle.configurationcache.extensions.capitalized
    import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

    plugins {
      alias(libs.plugins.android.application)
      alias(libs.plugins.org.jetbrains.kotlin.android)
      alias(libs.plugins.compose.compiler)
      alias(libs.plugins.hilt.gradle)
      alias(libs.plugins.protobuf)
      id("com.google.devtools.ksp")
    }

    android {
      namespace = "dev.listless.taskhopper"
      compileSdk = 35

      defaultConfig {
        applicationId = "dev.listless.taskhopper"
        minSdk = 33
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        vectorDrawables {
          useSupportLibrary = true
        }
      }

      buildTypes {
        release {
          isMinifyEnabled = false
          proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
          )
        }
      }
      compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
      }
      kotlinOptions {
        jvmTarget = "1.8"
      }
      buildFeatures {
        compose = true
      }
      composeOptions {
        kotlinCompilerExtensionVersion = "1.5.1"
      }
      packaging {
        resources {
          excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
      }
    }

    hilt {
      enableAggregatingTask = true
    }

    protobuf {
      protoc {
        // https://mvnrepository.com/artifact/com.google.protobuf/protoc
        artifact = "com.google.protobuf:protoc:4.30.2"
      }
      generateProtoTasks {
        all().forEach { task ->
          task.plugins {
            id("java") {
              option("lite")
            }
          }
          task.builtins {
            id("kotlin") {
              option("lite")
            }
          }
        }
      }
    }

    androidComponents {
      onVariants(selector().all()) { variant ->
        afterEvaluate {
          val capName = variant.name.capitalized()
          val kspTask = tasks.named("ksp${capName}Kotlin")
          val kspOutput = kspTask.map { it.outputs.files }

          kotlin.sourceSets.findByName(variant.name)?.kotlin?.srcDirs(kspOutput)
          kotlin.sourceSets.findByName("${variant.name}UnitTest")?.kotlin?.srcDirs(kspOutput)
          kotlin.sourceSets.findByName("${variant.name}AndroidTest")?.kotlin?.srcDirs(kspOutput)
        }
      }
    }

    dependencies {

      implementation(libs.androidx.core.ktx)
      implementation(libs.androidx.lifecycle.runtime.ktx)
      implementation(libs.androidx.activity.compose)
      implementation(platform(libs.androidx.compose.bom))
      implementation(libs.androidx.ui)
      implementation(libs.androidx.ui.graphics)
      implementation(libs.androidx.ui.tooling.preview)
      implementation(libs.androidx.material3)
      testImplementation(libs.junit)
      androidTestImplementation(libs.androidx.junit)
      androidTestImplementation(libs.androidx.espresso.core)
      androidTestImplementation(platform(libs.androidx.compose.bom))
      androidTestImplementation(libs.androidx.ui.test.junit4)
      debugImplementation(libs.androidx.ui.tooling)
      debugImplementation(libs.androidx.ui.test.manifest)

      // Hilt
      implementation(libs.hilt.android)
      ksp(libs.hilt.compiler)
      // For instrumentation tests
      androidTestImplementation(libs.hilt.android.testing)
      kspAndroidTest(libs.hilt.compiler)
      // For local unit tests
      testImplementation(libs.hilt.android.testing)
      kspTest(libs.hilt.compiler)

      // Protobuf
      implementation(libs.protobuf.kotlin.lite)
      implementation(libs.protobuf.java.lite)
      // Proto Datastore
      implementation(libs.androidx.datastore)
    }
    ```

=== "libs.versions.toml"

    ```toml
    [versions]
    agp = "8.6.1"
    kotlin = "2.1.20"
    coreKtx = "1.16.0"
    junit = "4.13.2"
    junitVersion = "1.2.1"
    espressoCore = "3.6.1"
    lifecycleRuntimeKtx = "2.8.7"
    activityCompose = "1.10.1"
    composeBom = "2025.04.01"
    hiltAndroid = "2.56.2"
    datastore = "1.1.5"
    protobufLite = "4.30.2"
    protobufGradlePlugin = "0.9.4"

    [libraries]
    androidx-core-ktx = { group = "androidx.core", name = "core-ktx", version.ref = "coreKtx" }
    junit = { group = "junit", name = "junit", version.ref = "junit" }
    androidx-junit = { group = "androidx.test.ext", name = "junit", version.ref = "junitVersion" }
    androidx-espresso-core = { group = "androidx.test.espresso", name = "espresso-core", version.ref = "espressoCore" }
    androidx-lifecycle-runtime-ktx = { group = "androidx.lifecycle", name = "lifecycle-runtime-ktx", version.ref = "lifecycleRuntimeKtx" }
    androidx-activity-compose = { group = "androidx.activity", name = "activity-compose", version.ref = "activityCompose" }
    androidx-compose-bom = { group = "androidx.compose", name = "compose-bom", version.ref = "composeBom" }
    androidx-ui = { group = "androidx.compose.ui", name = "ui" }
    androidx-ui-graphics = { group = "androidx.compose.ui", name = "ui-graphics" }
    androidx-ui-tooling = { group = "androidx.compose.ui", name = "ui-tooling" }
    androidx-ui-tooling-preview = { group = "androidx.compose.ui", name = "ui-tooling-preview" }
    androidx-ui-test-manifest = { group = "androidx.compose.ui", name = "ui-test-manifest" }
    androidx-ui-test-junit4 = { group = "androidx.compose.ui", name = "ui-test-junit4" }
    androidx-material3 = { group = "androidx.compose.material3", name = "material3" }
    hilt-android = { module = "com.google.dagger:hilt-android", version.ref = "hiltAndroid" }
    hilt-android-testing = { module = "com.google.dagger:hilt-android-testing", version.ref = "hiltAndroid" }
    hilt-compiler = { module = "com.google.dagger:hilt-compiler", version.ref = "hiltAndroid" }
    # https://mvnrepository.com/artifact/com.google.protobuf/protobuf-kotlin-lite
    protobuf-kotlin-lite = { module = "com.google.protobuf:protobuf-kotlin-lite", version.ref = "protobufLite" }
    # https://mvnrepository.com/artifact/com.google.protobuf/protobuf-javalite
    protobuf-java-lite = { module = "com.google.protobuf:protobuf-javalite", version.ref = "protobufLite" }
    androidx-datastore = { module = "androidx.datastore:datastore", version.ref = "datastore" }

    [plugins]
    android-application = { id = "com.android.application", version.ref = "agp" }
    org-jetbrains-kotlin-android = { id = "org.jetbrains.kotlin.android", version.ref = "kotlin" }
    compose-compiler = { id = "org.jetbrains.kotlin.plugin.compose", version.ref = "kotlin" }
    hilt-gradle = { id = "com.google.dagger.hilt.android", version.ref = "hiltAndroid" }
    protobuf = { id = "com.google.protobuf", version.ref = "protobufGradlePlugin" }
    ```

## Protobuf

=== "build.gradle.kts"

    ```kotlin
    // Protobuf support.
    alias(libs.plugins.protobuf) apply false
    ```

=== "app/build.gradle.kts"

    ```kotlin
    plugins {
      ...
      // Protobuf support.
      alias(libs.plugins.protobuf)
    }

    ...

    protobuf {
      protoc {
        artifact = "com.google.protobuf:protoc:4.31.1"
      }
      generateProtoTasks {
        all().forEach { task ->
          task.builtins {
            create("java") {
              option("lite")
            }
            create("kotlin") {
              option("lite")
            }
          }
        }
      }
    }

    dependencies {
      ...
      // Protobuf support.
      implementation(libs.protobuf.javalite)
      implementation(libs.protobuf.kotlin.lite)
    }
    ```

=== "libs.versions.toml"

    ```toml
    [versions]
    ...
    # Protobuf support.
    protobufJavalite = "4.31.1" # (1)
    protobufKotlinLite = "4.31.1" # (2)
    protobufGradlePlugin = "0.9.5" # (3)

    [libraries]
    ...
    # Protobuf support.
    protobuf-javalite = { module = "com.google.protobuf:protobuf-javalite", version.ref = "protobufJavalite" }
    protobuf-kotlin-lite = { module = "com.google.protobuf:protobuf-kotlin-lite", version.ref = "protobufKotlinLite" }

    [plugins]
    ...
    # Protobuf support.
    protobuf = { id = "com.google.protobuf", version.ref = "protobufGradlePlugin" }
    ```

    1.  [protobuf-javalite](https://mvnrepository.com/artifact/com.google.protobuf/protobuf-javalite)
    2.  [protobuf-kotlin-lite](https://mvnrepository.com/artifact/com.google.protobuf/protobuf-kotlin-lite)
    3.  [protobuf-gradle-plugin](https://mvnrepository.com/artifact/com.google.protobuf/protobuf-gradle-plugin)

## Google fonts

=== "app/build.gradle.kts"

    ```kotlin
    dependencies {
      ...
      // Google fonts support.
      implementation(libs.androidx.ui.text.google.fonts)
    }
    ```

=== "libs.versions.toml"

    ```toml
        [versions]
        ...
        # Google fonts support.
        uiTextGoogleFonts = "1.8.3" # (1)

        [libraries]
        ...
        # Google fonts support.
        androidx-ui-text-google-fonts = { module = "androidx.compose.ui:ui-text-google-fonts", version.ref = "uiTextGoogleFonts" }

        ...
    ```

    1.  [ui-text-google-fonts](https://mvnrepository.com/artifact/androidx.compose.ui/ui-text-google-fonts)
