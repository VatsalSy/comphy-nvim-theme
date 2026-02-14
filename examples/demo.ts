/**
 * TypeScript Demo - CoMPhy Gruvbox Theme
 * Demonstrates TypeScript-specific syntax highlighting
 */

// Type imports and exports
import type { Request, Response } from 'express';

// Basic types and interfaces
type ID = string | number;
type Status = 'pending' | 'active' | 'completed' | 'failed';

interface User {
    id: ID;
    name: string;
    email: string;
    age?: number;
    readonly createdAt: Date;
}

interface Admin extends User {
    role: 'admin';
    permissions: string[];
}

// Generic interfaces
interface Repository<T> {
    findById(id: ID): Promise<T | null>;
    findAll(filter?: Partial<T>): Promise<T[]>;
    save(entity: T): Promise<T>;
}

// Enums
enum LogLevel {
    Debug = 'DEBUG',
    Info = 'INFO',
    Warning = 'WARNING',
    Error = 'ERROR'
}

// Classes with TypeScript features
abstract class BaseEntity {
    abstract id: ID;
    protected constructor(public readonly createdAt: Date = new Date()) {}
    abstract validate(): boolean;
}

class UserEntity extends BaseEntity implements User {
    private _email: string;

    constructor(
        public id: ID,
        public name: string,
        email: string,
        public age?: number
    ) {
        super();
        this._email = email;
    }

    get email(): string {
        return this._email;
    }

    validate(): boolean {
        return !!(this.id && this.name && this._email);
    }
}

// Decorators
function Logger(prefix: string) {
    return function <T extends { new(...args: any[]): {} }>(constructor: T) {
        return class extends constructor {
            constructor(...args: any[]) {
                super(...args);
                console.log(`${prefix}: Creating instance`);
            }
        };
    };
}

// Advanced type manipulation
type DeepPartial<T> = T extends object ? {
    [P in keyof T]?: DeepPartial<T[P]>;
} : T;

// Conditional types
type IsArray<T> = T extends any[] ? true : false;

// Template literal types
type HTTPMethod = 'GET' | 'POST' | 'PUT' | 'DELETE';
type RoutePattern = `/${string}`;
type APIRoute = `${HTTPMethod} ${RoutePattern}`;

// Function overloading
function processValue(value: string): string;
function processValue(value: number): number;
function processValue(value: string | number): string | number {
    if (typeof value === 'string') {
        return value.toUpperCase();
    }
    return value * 2;
}

// Type guards
function isAdmin(user: User | Admin): user is Admin {
    return 'role' in user && user.role === 'admin';
}

// Export statements
export { UserEntity };
export type { Repository };
