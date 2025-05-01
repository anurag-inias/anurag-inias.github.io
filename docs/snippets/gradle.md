# Gradle configuration

=== "build.gradle.kts"

    ```kotlin
    // Top-level build file where you can add configuration options common to all sub-projects/modules.
    plugins {
      alias(libs.plugins.android.application) apply false
      alias(libs.plugins.kotlin.android) apply false
      alias(libs.plugins.hilt.gradle) apply false
      alias(libs.plugins.protobuf) apply false
      // Need to be exact same version as Kotlin
      // https://mvnrepository.com/artifact/com.google.devtools.ksp/com.google.devtools.ksp.gradle.plugin
      id("com.google.devtools.ksp") version "2.0.0-1.0.24"
    }
    ```

=== "app/build.gradle.kts"

    ```kotlin
    import com.google.protobuf.gradle.id
    import org.gradle.configurationcache.extensions.capitalized
    import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

    plugins {
      alias(libs.plugins.android.application)
      alias(libs.plugins.kotlin.android)
      alias(libs.plugins.compose.compiler)
      alias(libs.plugins.hilt.gradle)
      alias(libs.plugins.protobuf)
      id("com.google.devtools.ksp")
    }

    android {
      namespace = "dev.listless.example"
      compileSdk = 35

      defaultConfig {
        applicationId = "dev.listless.example"
        minSdk = 34
        targetSdk = 34
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
        artifact = "com.google.protobuf:protoc:4.28.3"
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
          tasks.getByName<KotlinCompile>("ksp${capName}Kotlin") {
            setSource(tasks.getByName("generate${capName}Proto").outputs)
          }
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
    kotlin = "2.0.0"
    coreKtx = "1.15.0"
    junit = "4.13.2"
    junitVersion = "1.2.1"
    espressoCore = "3.6.1"
    lifecycleRuntimeKtx = "2.8.7"
    activityCompose = "1.9.3"
    composeBom = "2024.10.01"
    hiltAndroid = "2.52"
    datastore = "1.1.1"
    protobufLite = "4.28.3"
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
    androidx-datastore = { module = "androidx.datastore:datastore", version.ref = "datastore" }
    hilt-android = { module = "com.google.dagger:hilt-android", version.ref = "hiltAndroid" }
    hilt-android-testing = { module = "com.google.dagger:hilt-android-testing", version.ref = "hiltAndroid" }
    hilt-compiler = { module = "com.google.dagger:hilt-compiler", version.ref = "hiltAndroid" }
    protobuf-kotlin-lite = { module = "com.google.protobuf:protobuf-kotlin-lite", version.ref = "protobufLite" }
    protobuf-java-lite = { module = "com.google.protobuf:protobuf-javalite", version.ref = "protobufLite" }

    [plugins]
    android-application = { id = "com.android.application", version.ref = "agp" }
    kotlin-android = { id = "org.jetbrains.kotlin.android", version.ref = "kotlin" }
    compose-compiler = { id = "org.jetbrains.kotlin.plugin.compose", version.ref = "kotlin" }
    hilt-gradle = { id = "com.google.dagger.hilt.android", version.ref = "hiltAndroid" }
    protobuf = { id = "com.google.protobuf", version.ref = "protobufGradlePlugin" }
    ```
