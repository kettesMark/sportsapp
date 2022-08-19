import React from "react";
import Sport from "./Sport";
import Sportevent from "./Sportevent";
import Outcome from "./Outcome";
import { BrowserRouter,  Routes,  Route } from "react-router-dom";

export default function Sportsapp() {
    return (
      <BrowserRouter>
        <Routes>
            <Route path="/" element={<Sport />} />
                <Route path="/events/:sportId" element={<Sportevent />} />
                    <Route path="/events/:sportId/outcomes/:eventId" element={<Outcome />} />
                <Route
                    path="*"
                    element={
                        <main style={{ padding: "1rem" }}>
                        <p>Sorry, nothing here.</p>
                        </main>
                    }
                />
        </Routes>
      </BrowserRouter>
    );
  }