# Graph

## Representation

=== "Implementation"

    ```java
    import java.util.HashMap;
    import java.util.HashSet;
    import java.util.Iterator;
    import java.util.Map;
    import java.util.Set;
    import java.util.stream.Collectors;

    public class Graph {

      private boolean isDirected;
      private boolean isWeighted;
      private Map<Integer, Set<Integer>> adjacencyMap;
      private Map<Pair, Integer> weights;

      private Graph(boolean isDirected, boolean isWeighted) {
        this.isDirected = isDirected;
        this.isWeighted = isWeighted;
        this.adjacencyMap = new HashMap<>();
        this.weights = new HashMap<>();
      }

      public static Graph create() {
        return new Graph(/* isDirected= */ false, /* isWeighted= */ false);
      }

      public static Graph weighted() {
        return new Graph(/* isDirected= */ false, /* isWeighted= */ true);
      }

      public static Graph directed() {
        return new Graph(/* isDirected= */ true, /* isWeighted= */ false);
      }

      public void addVertex(int vertex) {
        adjacencyMap.putIfAbsent(vertex, new HashSet<>());
      }

      public void addEdge(int source, int destination, int weight) {
        addVertex(source);
        addVertex(destination);

        adjacencyMap.get(source).add(destination);
        if (!isDirected)
          adjacencyMap.get(destination).add(source);
        
        if (isWeighted) {
          weights.put(new Pair(source, destination), weight);
          if (!isDirected)
            weights.put(new Pair(destination, source), weight);
        }
      }

      public Set<Integer> neighbours(int vertex) {
        return adjacencyMap.get(vertex);
      }

      public static Graph directedAndWeighted() {
        return new Graph(true, true);
      }

      private record Pair(int first, int second) {}
    }
    ```

=== "`toString`"

    ```java
    @Override
    public String toString() {
      StringBuilder sb = new StringBuilder();
      sb.append("{\n");

      Iterator<Map.Entry<Integer, Set<Integer>>> iterator = adjacencyMap.entrySet().iterator();
      while (iterator.hasNext()) {
        Map.Entry<Integer, Set<Integer>> adjacencyList = iterator.next();
        sb.append("  ");
        sb.append(adjacencyList.getKey());

        if (!adjacencyList.getValue().isEmpty()) {
          sb.append(' ').append(isDirected ? '↦' : ':').append(' ');
          sb.append(adjacencyList.getValue().stream()
              .map(neighbour -> isWeighted ? String.format("%d w%d", neighbour,
                  weights.get(new Pair(adjacencyList.getKey(), neighbour)))
                  : Integer.toString(neighbour)).collect(
                  Collectors.joining(", ")));
        }

        sb.append(iterator.hasNext() ? ",\n" : "\n");
      }

      sb.append("}");
      return sb.toString();
    }
    ```

=== "Unit tests"

    ```java
    import static org.assertj.core.api.Assertions.assertThat;
    import static org.junit.jupiter.api.Assertions.*;

    import org.junit.jupiter.api.BeforeEach;
    import org.junit.jupiter.api.Test;

    class GraphTest {

      private Graph graph;

      @Test
      public void testEmpty() {
        graph = Graph.create();
        String expected = """
            {
            }""";

        assertThat(graph.toString()).isEqualTo(expected);
      }

      @Test
      public void testIsolated() {
        graph = Graph.create();
        for (int i = 1; i <= 10; i++)
          graph.addVertex(i);
        String expected = """
            {
              1,
              2,
              3,
              4,
              5,
              6,
              7,
              8,
              9,
              10
            }""";

        assertThat(graph.toString()).isEqualTo(expected);
      }

      @Test
      public void testAllConnected() {
        graph = Graph.create();
        for (int i = 1; i <= 10; i++)
          for (int j = 1; j <= 10; j++)
            if (i != j)
              graph.addEdge(i, j, 1);
        String expected = """
            {
              1 : 2, 3, 4, 5, 6, 7, 8, 9, 10,
              2 : 1, 3, 4, 5, 6, 7, 8, 9, 10,
              3 : 1, 2, 4, 5, 6, 7, 8, 9, 10,
              4 : 1, 2, 3, 5, 6, 7, 8, 9, 10,
              5 : 1, 2, 3, 4, 6, 7, 8, 9, 10,
              6 : 1, 2, 3, 4, 5, 7, 8, 9, 10,
              7 : 1, 2, 3, 4, 5, 6, 8, 9, 10,
              8 : 1, 2, 3, 4, 5, 6, 7, 9, 10,
              9 : 1, 2, 3, 4, 5, 6, 7, 8, 10,
              10 : 1, 2, 3, 4, 5, 6, 7, 8, 9
            }""";

        assertThat(graph.toString()).isEqualTo(expected);
      }

      @Test
      public void testDirected() {
        graph = Graph.directed();
        for (int i = 1; i <= 10; i++)
          for (int j = 1; j <= 10; j++)
            if (i != j)
              graph.addEdge(i, j, 1);
        String expected = """
            {
              1 ↦ 2, 3, 4, 5, 6, 7, 8, 9, 10,
              2 ↦ 1, 3, 4, 5, 6, 7, 8, 9, 10,
              3 ↦ 1, 2, 4, 5, 6, 7, 8, 9, 10,
              4 ↦ 1, 2, 3, 5, 6, 7, 8, 9, 10,
              5 ↦ 1, 2, 3, 4, 6, 7, 8, 9, 10,
              6 ↦ 1, 2, 3, 4, 5, 7, 8, 9, 10,
              7 ↦ 1, 2, 3, 4, 5, 6, 8, 9, 10,
              8 ↦ 1, 2, 3, 4, 5, 6, 7, 9, 10,
              9 ↦ 1, 2, 3, 4, 5, 6, 7, 8, 10,
              10 ↦ 1, 2, 3, 4, 5, 6, 7, 8, 9
            }""";

        assertThat(graph.toString()).isEqualTo(expected);
      }

      @Test
      public void testWeighted() {
        graph = Graph.weighted();
        for (int i = 1; i <= 10; i++)
          for (int j = 1; j <= 10; j++)
            if (i != j)
              graph.addEdge(i, j, i*j);
        String expected = """
            {
              1 : 2 w2, 3 w3, 4 w4, 5 w5, 6 w6, 7 w7, 8 w8, 9 w9, 10 w10,
              2 : 1 w2, 3 w6, 4 w8, 5 w10, 6 w12, 7 w14, 8 w16, 9 w18, 10 w20,
              3 : 1 w3, 2 w6, 4 w12, 5 w15, 6 w18, 7 w21, 8 w24, 9 w27, 10 w30,
              4 : 1 w4, 2 w8, 3 w12, 5 w20, 6 w24, 7 w28, 8 w32, 9 w36, 10 w40,
              5 : 1 w5, 2 w10, 3 w15, 4 w20, 6 w30, 7 w35, 8 w40, 9 w45, 10 w50,
              6 : 1 w6, 2 w12, 3 w18, 4 w24, 5 w30, 7 w42, 8 w48, 9 w54, 10 w60,
              7 : 1 w7, 2 w14, 3 w21, 4 w28, 5 w35, 6 w42, 8 w56, 9 w63, 10 w70,
              8 : 1 w8, 2 w16, 3 w24, 4 w32, 5 w40, 6 w48, 7 w56, 9 w72, 10 w80,
              9 : 1 w9, 2 w18, 3 w27, 4 w36, 5 w45, 6 w54, 7 w63, 8 w72, 10 w90,
              10 : 1 w10, 2 w20, 3 w30, 4 w40, 5 w50, 6 w60, 7 w70, 8 w80, 9 w90
            }""";

        assertThat(graph.toString()).isEqualTo(expected);
      }

    }
    ```