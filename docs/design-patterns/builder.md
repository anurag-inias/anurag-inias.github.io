# Builder

<style>
.md-logo img {
  content: url('/design-patterns/logo-light.png');
}

:root [data-md-color-scheme=slate] .md-logo img  {
  content: url('/design-patterns/logo-dark.png');
}
</style>

Pattern for building classes with a lot of members, which can be error-prone. Some of these members can be required, and some optional.

## Example

We have a simple example of a class with one required and one optional attribute.

```java linenums="1"
class Person {
  private String ssn;  // optional
  private String name; // required

  // Getters
  public String ssn() { return ssn; }
  public String name() { return name; }

  // Providing our own constructor ensures that Java
  // doesn't create the default one.
  private Person(PersonBuilder builder) {
    this.ssn = builder.ssn;
    this.name = builder.name;
  }

  public static class PersonBuilder {
    private String ssn;  // required
    private String name; // optional

    public PersonBuilder(String ssn) {
      this.ssn = ssn;
    }

    public PersonBuilder ssn(String ssn) {
      this.ssn = ssn;
      return this;
    }

    public PersonBuilder name(String name) {
      this.name = name;
      return this;
    }

    public Person build() {
      return new Person(this);
    }
  }
}
```

- I don't like the `getX` and `setX` naming convention. So ignore that.
- We get rid of the default constructor, otherwise there'd be no way to enforce the required field's presence.
- Enforce required fields by providing a constructor of builder class with these fields.

```java
var person = new PersonBuilder("1-2-3-4").name("John").build();
```
