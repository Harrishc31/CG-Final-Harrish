using UnityEngine;

public class ToonToggle : MonoBehaviour
{
    private Renderer objectRenderer;

    // Materials to toggle between
    public Material material1;  // First material
    public Material material2;  // Second material

    private bool isMaterial1Active = true;  // Track which material is currently applied

    void Start()
    {
        // Get the Renderer component attached to the object
        objectRenderer = GetComponent<Renderer>();

        // Set the initial material (you can set it to one of your materials here)
        objectRenderer.material = material1;
    }

    void Update()
    {
        // Toggle material on key press (e.g., the "T" key)
        if (Input.GetKeyDown(KeyCode.Y))
        {
            ToggleObjectMaterial();
        }
    }

    // Method to toggle materials
    void ToggleObjectMaterial()
    {
        // Toggle the material based on the current active one
        if (isMaterial1Active)
        {
            objectRenderer.material = material2;  // Apply the second material
        }
        else
        {
            objectRenderer.material = material1;  // Apply the first material
        }

        // Toggle the active state
        isMaterial1Active = !isMaterial1Active;
    }
}

//doesnt work